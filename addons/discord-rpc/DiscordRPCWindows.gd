class_name DiscordRPCWindows extends DiscordRPCConnection

var file: FileAccess

func get_possible_paths() -> Array[String]:
	return ["\\\\?\\pipe\\" + SOCKET_NAME]

func open(path: String) -> int:
	if is_open():
		return ERR_ALREADY_IN_USE

	file = FileAccess.open(path, FileAccess.READ_WRITE)
	return FileAccess.get_open_error()

func read() -> Array:
	if not is_open():
		return [-1, PackedByteArray()]
	
	var opcode: int = file.get_32()
	var length: int = file.get_32()
	var buffer: PackedByteArray = file.get_buffer(length)
	
	return [opcode, buffer]

func write(bytes: PackedByteArray) -> int:
	if is_open():
		file.store_buffer(bytes)
		return file.get_error()
	return ERR_UNCONFIGURED

func is_open() -> bool:
	return file and file.is_open()

func has_payload() -> bool:
	return is_open() and file.get_length() > 0

func close() -> void:
	if is_open():
		file.close()
		file = null

func _to_string() -> String:
	return "[DiscordRPCWindows:%d]" % get_instance_id()

