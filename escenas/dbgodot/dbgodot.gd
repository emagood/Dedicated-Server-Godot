extends Node

class_name BinaryBlockHandler

class BinaryDataBlock:
	var identifier: PackedByteArray
	var data_8bit: PackedByteArray
	var data_16bit: Array
	var data_32bit: Array
	var data_64bit: Array

	func _init(identifier: PackedByteArray, data_8bit: PackedByteArray, data_16bit: Array, data_32bit: Array, data_64bit: Array):
		self.identifier = identifier
		self.data_8bit = data_8bit
		self.data_16bit = data_16bit
		self.data_32bit = data_32bit
		self.data_64bit = data_64bit

var filename: String
var size_8bit: int
var size_16bit: int
var size_32bit: int
var size_64bit: int
var total_size: int  # Variable global para almacenar el tamaño total
var cache: Dictionary = {}
var cache_size: int = 5000000  # Tamaño máximo de la caché (opcional)

func _init(filename: String, size_8bit: int, size_16bit: int, size_32bit: int, size_64bit: int, cache_size: int = 1000):
	self.filename = filename
	self.size_8bit = size_8bit
	self.size_16bit = size_16bit
	self.size_32bit = size_32bit
	self.size_64bit = size_64bit
	self.cache_size = cache_size
	self.total_size = 8 + size_8bit + size_16bit * 2 + size_32bit * 4 + size_64bit * 8  # Calcular total_size aquí
	ensure_file_exists()

# Función para abrir el archivo
func open_file():
	return FileAccess.open(filename, FileAccess.READ_WRITE)

# Función para cerrar el archivo
func close_file(file):
	file.close()

# Función para asegurar que el archivo existe
func ensure_file_exists():
	if not FileAccess.file_exists(filename):
		var file = FileAccess.open(filename, FileAccess.WRITE)
		file.close()
		print("Archivo creado:", filename)

# Función para actualizar la caché
func update_cache(identifier: PackedByteArray, position: int):
	if cache_size > 0:
		if cache.size() >= cache_size and not cache.has(identifier):
			cache.erase(cache.keys()[0])  # Eliminar el elemento más antiguo
		cache[identifier] = position

# Función para obtener la posición desde la caché
func get_cached_position(identifier: PackedByteArray) -> int:
	return cache.get(identifier, -1)

# Función para guardar un bloque de datos
func save_data_block(identifier: PackedByteArray, data_8bit: PackedByteArray, data_16bit: Array, data_32bit: Array, data_64bit: Array):
	var block = BinaryDataBlock.new(identifier, data_8bit, data_16bit, data_32bit, data_64bit)
	var file = open_file()

	total_size
	var found_position = get_cached_position(identifier)
	var position = 0
	var file_length = file.get_length()

	if found_position == -1:
		while position < file_length:
			file.seek(position)
			var current_id = file.get_buffer(8)
			if current_id == identifier or current_id == PackedByteArray([0, 0, 0, 0, 0, 0, 0, 0]):
				found_position = position
				break
			position += total_size

	file.seek(found_position if found_position != -1 else file_length)
	_write_data_block(file, block)

	update_cache(identifier, found_position if found_position != -1 else file_length)
	close_file(file)
	return true

# Función para escribir un bloque de datos en el archivo
func _write_data_block(file, block: BinaryDataBlock):
	file.store_buffer(block.identifier)
	file.store_buffer(block.data_8bit)

	for value in block.data_16bit:
		file.store_16(value)

	for value in block.data_32bit:
		file.store_32(value)

	for value in block.data_64bit:
		file.store_64(value)

# Función para cargar un bloque de datos
func load_data_block(identifier: PackedByteArray) -> BinaryDataBlock:
	var position = get_cached_position(identifier)
	if position == -1:
		var file = open_file()
		total_size
		var file_length = file.get_length()
		position = 0
		while position < file_length:
			file.seek(position)
			var current_id = file.get_buffer(8)
			if current_id == identifier:
				update_cache(identifier, position)
				break
			position += total_size

		close_file(file)

	if position != -1:
		var file = open_file()
		file.seek(position)
		var data_8bit = file.get_buffer(size_8bit)

		var data_16bit = []
		for i in range(size_16bit):
			data_16bit.append(file.get_16())

		var data_32bit = []
		for i in range(size_32bit):
			data_32bit.append(file.get_32())

		var data_64bit = []
		for i in range(size_64bit):
			data_64bit.append(file.get_64())

		close_file(file)
		return BinaryDataBlock.new(identifier, data_8bit, data_16bit, data_32bit, data_64bit)

	return null

# Función para verificar si un bloque existe
func block_exists(identifier: PackedByteArray) -> bool:
	var position = get_cached_position(identifier)
	if position != -1:
		return true

	var file = open_file()
	total_size
	position = 0
	var file_length = file.get_length()

	while position < file_length:
		file.seek(position)
		if file.get_buffer(8) == identifier:
			close_file(file)
			update_cache(identifier, position)
			return true
		position += total_size

	close_file(file)
	return false

# Función para eliminar un bloque de datos
func delete_data_block(identifier: PackedByteArray):
	if not block_exists(identifier):
		print("Error: El identificador no existe. No se puede eliminar el bloque.")
		return false

	var file = open_file()
	total_size

	while file.get_position() < file.get_length():
		var initial_position = file.get_position()
		var current_id = file.get_buffer(8)
		if current_id == identifier:
			file.seek(initial_position)
			file.store_buffer(PackedByteArray([0, 0, 0, 0, 0, 0, 0, 0]))  # Establecer el identificador a 0
			close_file(file)
			return true
		file.seek(initial_position + total_size)

	close_file(file)
	return false

# Función para actualizar un bloque de datos
func update_data_block(identifier: PackedByteArray, block_type: String, position: int, value):
	if not block_exists(identifier):
		print("Error: El identificador no existe. No se puede actualizar el bloque.")
		return false

	var file = open_file()
	total_size

	while file.get_position() < file.get_length():
		var initial_position = file.get_position()
		var current_id = file.get_buffer(8)
		if current_id == identifier:
			file.seek(initial_position)

			if block_type == "8bit" and position < size_8bit:
				file.seek(file.get_position() + 8 + position)
				file.store_8(value)
			elif block_type == "16bit" and position < size_16bit:
				file.seek(file.get_position() + 8 + size_8bit + position * 2)
				file.store_16(value)
			elif block_type == "32bit" and position < size_32bit:
				file.seek(file.get_position() + 8 + size_8bit + size_16bit * 2 + position * 4)
				file.store_32(value)
			elif block_type == "64bit" and position < size_64bit:
				file.seek(file.get_position() + 8 + size_8bit + size_16bit * 2 + size_32bit * 4 + position * 8)
				file.store_64(value)

			close_file(file)
			return true

		file.seek(initial_position + total_size)

	close_file(file)
	return false




# Función para leer un string desde una posición específica en el bloque de 8 bits

func read_string(identifier: PackedByteArray, start: int, end: int) -> String:
	var block = load_data_block(identifier)
	if block and start >= 0 and end <= block.data_8bit.size() and start < end:
		var string_data = block.data_8bit.slice(start, end)
		return string_data.get_string_from_utf8()
	return ""

# Función para guardar un string en el bloque de 8 bits
func save_string(identifier: PackedByteArray, start: int, data_string: String) -> void:
	var block = load_data_block(identifier)
	if block and start >= 0 and start + data_string.length() <= block.data_8bit.size():
		var utf8_data = data_string.to_utf8_buffer()
		for i in range(utf8_data.size()):
			block.data_8bit[start + i] = utf8_data[i]
		save_data_block(block.identifier, block.data_8bit, block.data_16bit, block.data_32bit, block.data_64bit)


func load_all_blocks(max_blocks: int = -1) -> Array:
	var blocks = []  # Lista para almacenar los bloques cargados
	var file = open_file()
	var blocks_loaded = 0

	# Leer el archivo bloque por bloque
	while file.get_position() < file.get_length():
		if max_blocks != -1 and blocks_loaded >= max_blocks:
			break

		var current_id = file.get_buffer(8)  # Leer el identificador del bloque

		if current_id != PackedByteArray([0, 0, 0, 0, 0, 0, 0, 0]):
			# Añadir el identificador a la caché si no está presente
			if not cache.has(current_id):
				cache[current_id] = file.get_position() - 8

			# Cargar el bloque de datos y añadirlo a la lista de bloques
			var block = current_id
			if block:
				blocks.append(block)
				blocks_loaded += 1

		# Mover el puntero de archivo al siguiente bloque
		file.seek(file.get_position() + total_size - 8)

	close_file(file)
	return blocks  # Retornar los bloques cargados


'''
/////////////////////////
////////////////////////////
//////////////////////////////////////////
////////////////////////////////////////////////////////
'''
