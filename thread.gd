extends Node

var data_thread = {
	"identifier": PackedByteArray([1, 2, 3, 4, 5, 6, 7, 8]),
	"num_files": 2,  # Número de hilos a utilizar
	"count": 0,
	"target_identifier": PackedByteArray([1, 2, 3, 4, 5, 6, 7, 8])  # Identificador a buscar
}

var thread: Thread
var thread2: Thread
var total_identifiers = 0
var thread_count = 0
var filename: String = "res://prueba_completa.dat"
var found_position = -1

# Variables para el tamaño de los bloques
var size_8bit: int = 255
var size_16bit: int = 256
var size_32bit: int = 0
var size_64bit: int = 0
var total_size: int = 8 + size_8bit + size_16bit * 2 + size_32bit * 4 + size_64bit * 8

func _ready():
	start_threads()
	print("Threads iniciados.")

func start_threads():
	var file_size = get_file_size()
	var half_size = int(file_size / 2 / total_size) * total_size  # Asegurarse de que es múltiplo de total_size

	# Primer hilo: desde el principio hasta el bloque justo antes del segundo hilo
	if thread == null or not thread.is_alive():
		thread = Thread.new()
		thread.start(_thread_function.bind({ "identifier": data_thread["identifier"], "start_position": 0, "end_position": half_size }))

	# Segundo hilo: desde la mitad hasta el final
	if thread2 == null or not thread2.is_alive():
		thread2 = Thread.new()
		thread2.start(_thread_function.bind({ "identifier": data_thread["identifier"], "start_position": half_size, "end_position": file_size }))

func stop_threads():
	if thread != null and thread.is_alive():
		thread.call_deferred("wait_to_finish")
		thread = null
	if thread2 != null and thread2.is_alive():
		thread2.call_deferred("wait_to_finish")
		thread2 = null
	print("Threads detenidos.")

func restart_threads():
	stop_threads()
	start_threads()
	print("Threads reiniciados.")

# Función que ejecutará cada thread
func _thread_function(userdata):
	var identifier = userdata["identifier"]
	var start_position = userdata["start_position"]
	var end_position = userdata["end_position"]
	var target_identifier = data_thread["target_identifier"]
	var count = 0
	var blocks_read = 0

	count += count_identifiers_in_range(start_position, end_position, blocks_read)
	if found_position == -1:
		found_position = find_identifier_in_range(start_position, end_position, target_identifier)

	print("Hilo desde posición ", start_position, " hasta ", end_position, " leyó ", blocks_read, " bloques.")
	
	total_identifiers += count
	thread_count += 1

	if thread_count >= data_thread["num_files"]:
		print("Total de identificadores válidos:", total_identifiers)
		if found_position != -1:
			print("Identificador encontrado en la posición:", found_position)
		else:
			print("Identificador no encontrado.")

func count_identifiers_in_range(start_position: int, end_position: int, blocks_read: int) -> int:
	var file = FileAccess.open(filename, FileAccess.READ)
	if file == null:
		print("Error al abrir el archivo en el rango", start_position, "a", end_position)
		return 0

	var count = 0
	file.seek(start_position)
	while file.get_position() < end_position:
		var current_id = file.get_buffer(8)
		if current_id != PackedByteArray([0, 0, 0, 0, 0, 0, 0, 0]):
			count += 1
		file.seek(file.get_position() + total_size - 8)
		blocks_read += 1
	file.close()
	return count

func find_identifier_in_range(start_position: int, end_position: int, target_identifier: PackedByteArray) -> int:
	var file = FileAccess.open(filename, FileAccess.READ)
	if file == null:
		print("Error al abrir el archivo en el rango", start_position, "a", end_position)
		return -1

	var found_position = -1
	file.seek(start_position)
	while file.get_position() < end_position:
		var current_id = file.get_buffer(8)
		if current_id == target_identifier:
			found_position = file.get_position() - 8
			break
		file.seek(file.get_position() + total_size - 8)
	file.close()
	return found_position

func get_file_size() -> int:
	var file = FileAccess.open(filename, FileAccess.READ)
	if file == null:
		print("Error al abrir el archivo para obtener su tamaño.")
		return 0

	var size = file.get_length()
	file.close()
	return size

func _exit_tree():
	stop_threads()
	print("Esperando a que los threads terminen.")

func _input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_W):
		restart_threads()
