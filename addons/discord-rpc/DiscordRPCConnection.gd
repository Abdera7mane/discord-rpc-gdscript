class_name DiscordRPCConnection

signal payload_received(payload: Payload)

const SOCKET_NAME: String = "discord-ipc-%d"

func get_possible_paths() -> Array[String]:
	return []

func open(_path: String) -> int:
	return ERR_UNAVAILABLE

func read() -> Array:
	return [-1, PackedByteArray()]

func write(_bytes: PackedByteArray) -> int:
	return ERR_UNAVAILABLE

func is_open() -> bool:
	return false

func has_payload() -> bool:
	return false

func close() -> void:
	pass

func post(request: Payload) -> int:
	var error: int = write(request.to_bytes()) if is_open() else ERR_UNCONFIGURED 
	if error != OK:
		push_error("DiscordRPC: Write error: ", error)
	return error

func scan() -> Payload:
	if not is_open():
		push_error("DiscordRPC: Can not recieve payloads while disconnected")
		return null
	
	var data: Array = read()
	var opcode: int = data[0]
	var buffer: PackedByteArray = data[1]
	
	var body: Dictionary = JSON.parse_string(buffer.get_string_from_utf8())
	
	var response: Payload = Payload.new()
	response.opcode = opcode
	response.nonce = body["nonce"] if body.get("nonce") else ""
	response.command = body["cmd"] if body.get("cmd") else ""
	response.event = body["evt"] if body.get("evt") else ""
	response.data = body["data"] if body.get("data") is Dictionary else body
	response.arguments = body["args"] if body.get("args") is Dictionary else {}

	return response

func send(request: Payload) -> Payload:
	if not is_open():
		push_error("DiscordRPC: Can not send payloads while disconnected")
		return null
	
	var opcode: int = request.opcode
	var nonce: String = request.nonce

	if post(request) != OK:
		return null

	var response: Payload = null
	while not response:
		var payload: Payload = await payload_received
		if opcode == Payload.OpCodes.HANDSHAKE:
			response = payload
		elif payload.nonce == nonce:
			response = payload

	if response.is_error():
		push_error("DiscordRPC: ", response.get_error_messsage())

	return response

func poll() -> void:
	if has_payload():
		var payload: Payload = scan()
		if payload:
			payload_received.emit(payload)

class Payload:
	enum OpCodes {
		HANDSHAKE,
		FRAME,
		CLOSE,
		PING,
		PONG
	}

	var opcode: int = OpCodes.PING
	var nonce: String
	var command: String
	var event: String
	var data: Dictionary
	var arguments: Dictionary

	func _init() -> void:
		generate_nonce()

	func generate_nonce() -> void:
		nonce = Marshalls.raw_to_base64(Crypto.new().generate_random_bytes(12))

	func is_event_dispatch() -> bool:
		return command == DiscordRPC.Commands.DISPATCH

	func is_error() -> bool:
		return event == DiscordRPC.Events.ERROR or data.has_all(["code", "message"])

	func is_close_request() -> bool:
		return opcode == OpCodes.CLOSE

	func get_error_code() -> int:
		return data["code"] if is_error() else OK

	func get_error_messsage() -> String:
		return data["message"] if is_error() else ""

	func to_dict() -> Dictionary:
		return {
			nonce = self.nonce,
			cmd = self.command,
			# warning-ignore:incompatible_ternary
			evt = self.event if not event.is_empty() else null,
			data = self.data,
			args = self.arguments
		}

	func to_bytes() -> PackedByteArray:
		var buffer: PackedByteArray = JSON.stringify(to_dict()).to_utf8_buffer()
		var stream: StreamPeerBuffer = StreamPeerBuffer.new()

		stream.put_32(opcode)
		stream.put_32(buffer.size())
		# warning-ignore:return_value_discarded
		stream.put_data(buffer)

		return stream.data_array

	func _to_string() -> String:
		return "[Payload:%d:opcode=%d]" % [get_instance_id(), opcode]

