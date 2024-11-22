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
var cache_size: int = 1000  # Tamaño máximo de la caché (opcional)
var index: Dictionary = {}  # Índice para búsqueda rápida

func _init(filename: String, size_8bit: int, size_16bit: int, size_32bit: int, size_64bit: int, cache_size: int = 1000):
	self.filename = filename
	self.size_8bit = size_8bit
	self.size_16bit = size_16bit
	self.size_32bit = size_32bit
	self.size_64bit = size_64bit
	self.cache_size = cache_size
	self.total_size = 8 + size_8bit + size_16bit * 2 + size_32bit * 4 + size_64bit * 8  # Calcular total_size aquí
	ensure_file_exists()

# Ahora puedes usar total_size en cualquier lugar de la clase sin recalcularlo cada vez


func open_file():
	return FileAccess.open(filename, FileAccess.READ_WRITE)

func close_file(file):
	file.close()

func ensure_file_exists():
	if not FileAccess.file_exists(filename):
		var file = FileAccess.open(filename, FileAccess.WRITE)
		file.close()
		print("Archivo creado:", filename)

func update_cache(identifier: PackedByteArray, position: int):
	if cache_size > 0:
		if cache.size() >= cache_size and not cache.has(identifier):
			cache.erase(cache.keys()[0])  # Eliminar el elemento más antiguo
		cache[identifier] = position

func get_cached_position(identifier: PackedByteArray) -> int:
	return cache.get(identifier, -1)

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
	# Actualiza el índice con la posición del bloque
	index[identifier] = found_position if found_position != -1 else file_length

	close_file(file)
	return true

func _write_data_block(file, block: BinaryDataBlock):
	file.store_buffer(block.identifier)
	file.store_buffer(block.data_8bit)

	for value in block.data_16bit:
		file.store_16(value)

	for value in block.data_32bit:
		file.store_32(value)

	for value in block.data_64bit:
		file.store_64(value)
func load_data_block(identifier: PackedByteArray) -> BinaryDataBlock:
	# Usa el índice para encontrar la posición del bloque
	var position = index.get(identifier, -1)
	if position == -1:
		# Si el índice no tiene la posición, busca en el archivo
		position = get_cached_position(identifier)
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
					index[identifier] = position  # Actualiza el índice
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

func block_exists(identifier: PackedByteArray) -> bool:
	if index.has(identifier):
		return true

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
			index[identifier] = position
			return true
		position += total_size

	close_file(file)
	return false

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
			index.erase(identifier)  # Eliminar del índice
			return true
		file.seek(initial_position + total_size)

	close_file(file)
	return false

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


func load_all_blocks() -> Array:
	var blocks = []  # Lista para almacenar los bloques cargados
	var file = open_file()

	# Leer el archivo bloque por bloque
	while file.get_position() < file.get_length():
		var current_id = file.get_buffer(8)  # Leer el identificador del bloque

		if current_id != PackedByteArray([0, 0, 0, 0, 0, 0, 0, 0]):
			# Añadir el identificador al índice si no está presente
			if not index.has(current_id):
				index[current_id] = file.get_position() - 8

		# Mover el puntero de archivo al siguiente bloque
		file.seek(file.get_position() + total_size - 8)

	close_file(file)
	return index.keys()  # Retornar solo los identificadores


'''
/////////////////////////
////////////////////////////
//////////////////////////////////////////
////////////////////////////////////////////////////////
'''
