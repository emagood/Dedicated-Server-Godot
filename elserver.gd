extends Control


func _ready() -> void:
	prueba_completa2()

	prueba_completa3()

# (Resto de tus funciones...)

func prueba_completa3():
	pass
	#var binary_block_handler = BinaryBlockHandler.new("prueba_completa.dat", 256, 255, 0, 4)  # Ajustar tamaño para data_16bit
	#
	## (Resto del código de prueba...)
#
	## Probar la función read_string
	##for user_id in user_identifiers:
		##var result_string = binary_block_handler.read_string(user_id, 1, 20)
		##print("String leído desde el bloque de 8 bits, posiciones 1 a 20:", result_string)
##
	##prints(binary_block_handler.index)
#extends Control
#
#func _ready() -> void:
	#prueba_completa2()
#
## (Resto de tus funciones...)
#
#func prueba_completa2():
	#var binary_block_handler = BinaryBlockHandler.new("prueba_completa.dat", 256, 255, 0, 4)  # Ajustar tamaño para data_16bit
	#
	## (Resto del código de prueba...)
#
	## Probar la función save_string
	#for user_id in user_identifiers:
		#var sample_string = "Hello, Binary!"
		#binary_block_handler.save_string(user_id, 1, sample_string)
		#print("String guardado en el bloque de 8 bits:", sample_string)
#
	## Probar la función read_string
	#for user_id in user_identifiers:
		#var result_string = binary_block_handler.read_string(user_id, 1, sample_string.length() + 1)
		#print("String leído desde el bloque de 8 bits, posiciones 1 a", sample_string.length() + 1, ":", result_string)
#
	#prints(binary_block_handler.index)
#



func string_to_packedbytearray(identifier_str: String) -> PackedByteArray:
	var identifier = int(identifier_str)
	var packed_identifier = PackedByteArray()
	prints(identifier , " identififador")
	for i in range(8):
		# Extrae cada byte del número de 64 bits
		packed_identifier.append((identifier >> (8 * (7 - i))) & 0xFF)

	return packed_identifier



func generate_random_identifier() -> PackedByteArray:
	var identifier = PackedByteArray()
	for i in range(8):
		identifier.append(randi_range(0, 255))
	return identifier

func generate_random_8bit_data(size) -> PackedByteArray:
	var data = PackedByteArray()
	for i in range(size):
		data.append(randi_range(0, 255))
	return data

func generate_random_16bit_data(size) -> Array:
	var data = []
	for i in range(size):
		data.append(randi_range(0, 65535))
	return data



func generate_random_32bit_data(size) -> Array:
	var data = []
	for i in range(size):
		data.append(randi_range(0, 4294967295))
	return data

func generate_random_64bit_data(size) -> Array:
	var data = []
	for i in range(size):
		data.append(randi_range(-9223372036854775808, 9223372036854775807))
	return data








func prueba_completa2():
	
	var binary_block_handler = BinaryBlockHandler.new("prueba_completa.dat", 256, 255, 0, 4)  # Ajustar tamaño para data_16bit
	
	var timer_local = Time.get_ticks_msec()
	#var timer_local2 = timer_local
	#prints("Tiempo inicial: " + str(Time.get_ticks_msec()))
	var all_blocks = binary_block_handler.load_all_blocks()
	if all_blocks.size() > 0:
		print("Se han cargado  (", all_blocks.size(), ")  bloques del archivo. en milisegundos (" , Time.get_ticks_msec() - timer_local ,") ")
	
	#return
	# Lista para almacenar los identificadores generados
	var user_identifiers = []

	for i in range(1):
		var user_id = generate_random_identifier()
		print("Generado identificador:", user_id)
		user_identifiers.append(user_id)
		var data_8bit = generate_random_8bit_data(256)
		var data_16bit = generate_random_16bit_data(255)
		var data_64bit = generate_random_64bit_data(4)

		print("Guardando datos para el identificador:", user_id)
		if not binary_block_handler.save_data_block(user_id, data_8bit, data_16bit, [], data_64bit):
			print("Error al guardar los datos del usuario con identificador:", user_id)
		else:
			print("Datos guardados correctamente para el identificador:", user_id)
			
	for user_id in user_identifiers:
		var sample_string = "Hello, Binary! mi nombre es emanuel y el tuyo ??"
		binary_block_handler.save_string(user_id, 0, sample_string)
		print("String guardado en el bloque de 8 bits:", sample_string)
		
	#for user_id in user_identifiers:
		#var result_string = binary_block_handler.read_string(user_id, 8,  60)
		#print("String leído desde el bloque de 8 bits, posiciones 1 a 20:", result_string)
#
	##prints(binary_block_handler.index)




	for user_id in user_identifiers:
		print("Verificando identificador:", user_id)
		var loaded_block = binary_block_handler.load_data_block(user_id)
		if loaded_block:
			print("Datos cargados para el identificador:", user_id)
			print("Datos de 8 bits:", loaded_block.data_8bit)
			print("Datos de 16 bits:", loaded_block.data_16bit)
			print("Datos de 64 bits:", loaded_block.data_64bit)
		else:
			print("No se encontraron datos para el identificador:", user_id)

	# Eliminar datos de los usuarios
	for user_id in user_identifiers:
		print("Eliminando identificador:", user_id)
		if binary_block_handler.block_exists(user_id):
			if binary_block_handler.delete_data_block(user_id):
				print("Eliminación exitosa para el identificador:", user_id)
			else:
				print("Error al eliminar los datos del usuario con identificador:", user_id)
		else:
			print("No se encontraron datos para el identificador:", user_id)

	# Comprobar que los usuarios han sido eliminados
	for user_id in user_identifiers:
		if binary_block_handler.block_exists(user_id):
			print("Error: El bloque con el identificador aún existe:", user_id)
		else:
			print("Confirmado: El bloque con el identificador ha sido eliminado:", user_id)

	# Agregar nuevamente los mismos 5 usuarios
	for user_id in user_identifiers:
		print("Agregando nuevamente datos para el identificador:", user_id)
		var data_8bit = generate_random_8bit_data(256)
		var data_16bit = generate_random_16bit_data(255)
		var data_64bit = generate_random_64bit_data(4)

		if not binary_block_handler.save_data_block(user_id, data_8bit, data_16bit, [], data_64bit):
			print("Error al guardar los datos del usuario con identificador:", user_id)
		else:
			print("Datos guardados correctamente para el identificador:", user_id)
#
	## Verificar y mostrar datos de los usuarios 
	#for user_id in user_identifiers:
		#print("Verificando identificador:", user_id)
		#var loaded_block = binary_block_handler.load_data_block(user_id)
		#if loaded_block:
			#print("Datos cargados para el identificador:", user_id)
			#print("Datos de 8 bits:", loaded_block.data_8bit)
			#print("Datos de 16 bits:", loaded_block.data_16bit)
			#print("Datos de 64 bits:", loaded_block.data_64bit)
		#else:
			#print("No se encontraron datos para el identificador:", user_id)
	
	#prints(binary_block_handler.index)
