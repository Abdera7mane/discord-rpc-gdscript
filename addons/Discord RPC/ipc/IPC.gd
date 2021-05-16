class_name IPC

signal data_recieved(payload)

var _pipe: NamedPipe
var _responses_pool: Array
var _requests_pool: Array

var _io_thread: Thread
var _mutex: Mutex

func open(path: String) -> int:
	self._pipe = get_pip()
	if (self._pipe):
		return self._pipe.open(path)
	return ERR_CANT_OPEN

func setup() -> bool:
	self._io_thread = Thread.new()
	self._mutex = Mutex.new()
	var error: int = self._io_thread.start(self, "_connection_loop", [self._mutex, self._pipe])
	if (error != OK):
		push_error("Failed to start IO Thread !")
		return false
	return true

func send(request: IPCPayload) -> IPCPayload:
	var op_code: int = request.op_code
	var nonce: String = request.nonce
	
	self._requests_pool.append(request)
	
	var response: IPCPayload = null
	
	while (not response):
		var payload: IPCPayload = yield(self, "data_recieved")
		if (op_code == IPCUtil.OpCodes.HANDSHAKE):
			response = payload
		elif (payload.nonce == nonce):
			response = payload
			
	return response

func post(request: IPCPayload) -> void:
	if (not self.is_open()):
		push_error("IPC: Can not send payloads while not connected to a discord client instance")
		return
	
	self._pipe.write(request.to_bytes())

func scan() -> IPCPayload:
	if (not self.is_open()):
		push_error("IPC: Can not recieve payloads while not connected to a discord client instance")
		return null
	
	var data: Array = self._pipe.read()
	var op_code: int = data[0]
	var buffer: PoolByteArray =  data[1]
	var parse_result: JSONParseResult = JSON.parse(buffer.get_string_from_utf8())
	if (parse_result.error != OK):
		push_error("Failed decoding packet of legnth: %d with opcode: %d" % [buffer.size(), op_code])
		return null
	
	var body: Dictionary = parse_result.result
	
	var response: IPCPayload = IPCPayload.new()
	response.op_code = op_code
	response.nonce = body["nonce"] if body.get("nonce") else ""
	response.command = body["cmd"] if body.get("cmd") else ""
	response.event = body["evt"] if body.get("evt") else ""
	response.data = body["data"] if body.has("data") else {}
	response.arguments = body["args"] if body.has("args") else {}
	
	return response

func is_open() -> bool:
	return self._pipe.is_open() if self._pipe else false

func close() -> void:
	if (_io_thread and _io_thread.is_active()):
		self._io_thread.wait_to_finish()
	self._pipe.close()

func poll() -> void:
	while (self._responses_pool.size() > 0):
		self._mutex.lock()
		self.emit_signal("data_recieved", self._responses_pool.pop_back())
		self._mutex.unlock()

func _connection_loop(data: Array) -> void:
	var mutex: Mutex = data[0]
	var pipe: NamedPipe = data[1]
	
	while (pipe.is_open()):
		if (pipe.has_reading()):
			var payload: IPCPayload = self.scan()
			mutex.lock()
			self._responses_pool.append(payload)
			mutex.unlock()
		
		elif (self._requests_pool.size() > 0):
			mutex.lock()
			self.post(self._requests_pool.pop_back())
			mutex.unlock()
		
		OS.delay_msec(10)

static func get_pip() -> NamedPipe:
	var pipe: NamedPipe
	var os: String = OS.get_name()
	if (os == "Windows"):
		pipe = WindowsPipe.new()
	
	elif (os in ["X11", "OSX"]):
		# Unimplemented yet
		pass

	return pipe

static func get_pipe_path(i: int) -> String:
	var path: String
	match OS.get_name():
		"Windows":
			path = "\\\\?\\pipe\\"
		_:
			for env_var in ["XDG_RUNTIME_DIR","TMPDIR","TMP","TEMP"]:
				if (OS.has_environment(env_var)):
					path = OS.get_environment(env_var) + "/"
					break
			if (path.empty()):
				path = "/tmp/"
		
	return path + "discord-ipc-%d" % i