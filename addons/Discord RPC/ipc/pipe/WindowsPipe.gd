class_name WindowsPipe extends NamedPipe

var _file: File

func _init() -> void:
	self._file = File.new()

func open(path: String) -> int:
	return self._file.open(path, File.READ_WRITE)

func read() -> Array:
	var op_code: int = self._file.get_32()
	var length: int = self._file.get_32()
	var buffer = self._file.get_buffer(length)
	return [op_code, buffer]

func write(bytes: PoolByteArray) -> void:
	self._file.store_buffer(bytes)

func is_open() -> bool:
	return self._file.is_open()

func has_reading() -> bool:
	return not self._file.get_len() == 0

func close() -> void:
	self._file.close()

func _to_string() -> String:
	return "[WindowsIPCPipe:%d]" % self.get_instance_id()
