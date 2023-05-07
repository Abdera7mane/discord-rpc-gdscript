class_name DiscordRPCUnix extends DiscordRPCConnection

# Discord Flatpak sub path
const FLATPAK: String = "/app/com.discordapp.Discord"

# Discord Snap sub path
const SNAP: String = "/snap.discord"

var stream: StreamPeer # StreamPeerUnix

func get_possible_paths() -> Array[String]:
	var path: String

	for env in ["XDG_RUNTIME_DIR", "TMPDIR", "TMP", "TEMP"]:
		if OS.has_environment(env):
			path = OS.get_environment(env)
			break

	if path.is_empty():
		path = "/tmp/"

	path += "{0}".path_join(SOCKET_NAME)

	return [path.format([""]), path.format([FLATPAK]), path.format([SNAP])]

func open(path: String) -> int:
	if is_open():
		return ERR_ALREADY_IN_USE

	stream = ClassDB.instantiate("StreamPeerUnix")
	return stream.open(path)

func read() -> Array:
	if not is_open():
		return [-1, PackedByteArray()]
	
	var opcode: int = stream.get_32()
	var length: int = stream.get_32()
	var buffer: PackedByteArray = stream.get_data(length)[1]
	
	return [opcode, buffer]

func write(bytes: PackedByteArray) -> int:
	return stream.put_data(bytes) if is_open() else ERR_UNCONFIGURED 

func is_open() -> bool:
	return stream and stream.is_open()

func has_payload() -> bool:
	return is_open() and stream.get_available_bytes() > 0

func close() -> void:
	if is_open():
		stream.close()
		stream = null

func _to_string() -> String:
	return "[DiscordRPCUnix:%d]" % get_instance_id()

