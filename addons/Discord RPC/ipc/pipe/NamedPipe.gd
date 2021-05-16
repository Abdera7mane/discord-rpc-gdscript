class_name NamedPipe

#func connect_to_client(path: String) -> int:
#	if (self.status != Status.DISCONNECTED):
#		push_error("Pipe is already in an active connection")
#		return ERR_ALREADY_IN_USE
#	self.status = Status.CONNECTING
#	if (self._connect(path)):
#		self._handshake()
#		var response: IPCPacket = self.scan()
#		if (response.op_code == IPC.OpCodes.CLOSE):
#			print(response.get_payload())
#			self.close()
#			return ERR_UNAUTHORIZED
#		self.status = Status.CONNECTED
#		self.emit_signal("connected", User.new(response.get_data()["user"]))
#		return OK
#	self._close()
#	self.status = Status.DISCONNECTED
#	return ERR_CANT_CONNECT

func open(_path: String) -> int:
	return ERR_UNAVAILABLE

func read() -> Array:
	return []

func write(_bytes: PoolByteArray) -> void:
	pass

func is_open() -> bool:
	return false

func has_reading() -> bool:
	return false

#func close() -> void:
#	self._close()
#	self.status = Status.DISCONNECTED
#	self.emit_signal("disconnected")

func close() -> void:
	pass

func _to_string() -> String:
	return "[IPCPipe:%d]" % self.get_instance_id()
