extends Control

'''
mas versatil me gusta :)
mas bugiado , si ves esto corre
no muevas 
'''
func _ready() -> void:
	prueba_completa2()
	var ID_USER = string_to_packedbytearray("-093846377487")
	prints(ID_USER)
	ID_USER = string_to_packedbytearray("093846377487")
	prints(ID_USER)
	#prueba()
	#prueba2()
	#prueba3()
	#prueba_verificacion_guardado()
	#prueba_completa2()
	#prueba_cocina_y_arroz()
	tengo_hambre()
	canto_de_pajaros()

func prueba():
	# Crear la instancia de BinaryBlockHandler con la configuración deseada
	
	var binary_block_handler = BinaryBlockHandler.new("usuarios_dato_8_16_32_64.dat", 256, 255, 255, 4)

	var user_identifiers = []

	# Generar y guardar datos para 100 usuarios
	for i in range(100):
		var user_id = generate_random_identifier()
		print("Generado identificador:", user_id)
		user_identifiers.append(user_id)  # Guardar el identificador
		var data_8bit = generate_random_8bit_data()
		var data_16bit = generate_random_16bit_data()
		var data_32bit = generate_random_32bit_data()
		var data_64bit = generate_random_64bit_data()

		print("Guardando datos para el identificador:", user_id)
		if not binary_block_handler.save_data_block(user_id, data_8bit, data_16bit, data_32bit, data_64bit):
			print("Error al guardar los datos del usuario con identificador:", user_id)

	# Leer y mostrar datos de los usuarios guardados para verificar
	for i in range(100):
		var user_id = user_identifiers[i]
		print("Verificando identificador:", user_id)
		var loaded_block = binary_block_handler.load_data_block(user_id)
		if loaded_block:
			print("Datos cargados para el identificador:", user_id)
			print("Datos de 8 bits:", loaded_block.data_8bit)
			print("Datos de 16 bits:", loaded_block.data_16bit)
			print("Datos de 32 bits:", loaded_block.data_32bit)
			print("Datos de 64 bits:", loaded_block.data_64bit)
		else:
			print("No se encontraron datos para el identificador:", user_id)


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

func generate_random_8bit_data() -> PackedByteArray:
	var data = PackedByteArray()
	for i in range(256):
		data.append(randi_range(0, 255))
	return data

func generate_random_16bit_data() -> Array:
	var data = []
	for i in range(255):
		data.append(randi_range(0, 65535))
	return data



func generate_random_32bit_data() -> Array:
	var data = []
	for i in range(255):
		data.append(randi_range(0, 4294967295))
	return data

func generate_random_64bit_data() -> Array:
	var data = []
	for i in range(4):
		data.append(randi_range(-9223372036854775808, 9223372036854775807))
	return data


func prueba2():

	var binary_block_handler = BinaryBlockHandler.new("usuarios_dato_8_16_64.dat", 256, 255, 0, 4)

	var user_identifiers = []

	for i in range(3):
		var user_id = generate_random_identifier()
		print("Generado identificador:", user_id)
		user_identifiers.append(user_id)  # Guardar el identificador
		var data_8bit = generate_random_8bit_data()
		var data_16bit = generate_random_16bit_data()
		var data_64bit = generate_random_64bit_data()

		# Pasar un Array vacío para los datos de 32 bits
		print("Guardando datos para el identificador:", user_id)
		if not binary_block_handler.save_data_block(user_id, data_8bit, data_16bit, [], data_64bit):
			print("Error al guardar los datos del usuario con identificador:", user_id)

	# Leer y mostrar datos de los usuarios guardados para verificar
	for i in range(3):
		var user_id = user_identifiers[i]
		print("Verificando identificador:", user_id)
		var loaded_block = binary_block_handler.load_data_block(user_id)
		if loaded_block:
			print("Datos cargados para el identificador:", user_id)
			print("Datos de 8 bits:", loaded_block.data_8bit)
			print("Datos de 16 bits:", loaded_block.data_16bit)
			print("Datos de 64 bits:", loaded_block.data_64bit)
		else:
			print("No se encontraron datos para el identificador:", user_id)





func prueba3():
	
	var binary_block_handler = BinaryBlockHandler.new("usuarios_dato_800_8_100_16_4_64.dat", 800, 100, 0, 4)

	# Lista para almacenar los identificadores generados
	var user_identifiers = []


	for i in range(100):
		var user_id = generate_random_identifier()
		print("Generado identificador:", user_id)
		user_identifiers.append(user_id)
		var data_8bit = generate_random_8bit_data()
		var data_16bit = generate_random_16bit_data()
		var data_64bit = generate_random_64bit_data()

	
		print("Guardando datos para el identificador:", user_id)
		if not binary_block_handler.save_data_block(user_id, data_8bit, data_16bit, [], data_64bit):
			print("Error al guardar los datos del usuario con identificador:", user_id)

	for i in range(100):
		var user_id = user_identifiers[i]
		print("Verificando identificador:", user_id)
		var loaded_block = binary_block_handler.load_data_block(user_id)
		if loaded_block:
			print("Datos cargados para el identificador:", user_id)
			print("Datos de 8 bits:", loaded_block.data_8bit)
			print("Datos de 16 bits:", loaded_block.data_16bit)
			print("Datos de 64 bits:", loaded_block.data_64bit)
		else:
			print("No se encontraron datos para el identificador:", user_id)







func prueba_completa():

	var binary_block_handler = BinaryBlockHandler.new("usuarios.dat", 800, 100, 0, 4)

	
	var user_identifiers = []

	# Generar y guardar datos para 5 usuarios
	for i in range(5):
		var user_id = generate_random_identifier()
		print("Generado identificador:", user_id)
		user_identifiers.append(user_id)
		var data_8bit = generate_random_8bit_data()
		var data_16bit = generate_random_16bit_data()
		var data_64bit = generate_random_64bit_data()

		# 
		print("Guardando datos para el identificador:", user_id)
		if not binary_block_handler.save_data_block(user_id, data_8bit, data_16bit, [], data_64bit):
			print("Error al guardar los datos del usuario con identificador:", user_id)
		else:
	
			print("Datos guardados correctamente para el identificador:", user_id)

	# Leer y mostrar datos de los usuarios guardados para verificar
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
				binary_block_handler.flush()  # Forzar el guardado sin cerrar el archivo
				print("Eliminación exitosa para el identificador:", user_id)
			else:
				print("Error al eliminar los datos del usuario con identificador:", user_id)
		else:
			print("No se encontraron datos para el identificador:", user_id)

	
	for user_id in user_identifiers:
		if binary_block_handler.block_exists(user_id):
			print("Error: El bloque con el identificador aún existe:", user_id)
		else:
			print("Confirmado: El bloque con el identificador ha sido eliminado:", user_id)

	
	for user_id in user_identifiers:
		print("Agregando nuevamente datos para el identificador:", user_id)
		var data_8bit = generate_random_8bit_data()
		var data_16bit = generate_random_16bit_data()
		var data_64bit = generate_random_64bit_data()

		if not binary_block_handler.save_data_block(user_id, data_8bit, data_16bit, [], data_64bit):
			print("Error al guardar los datos del usuario con identificador:", user_id)
		else:
			
			print("Datos guardados correctamente para el identificador:", user_id)

	
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



func prueba_verificacion_guardado():
	
	var binary_block_handler = BinaryBlockHandler.new("usuarios.dat", 256, 800, 0, 4)

	# Identificadores conocidos
	var identificador1 = PackedByteArray([1, 2, 3, 4, 5, 6, 7, 8])
	var identificador2 = PackedByteArray([9, 10, 11, 12, 13, 14, 15, 16])
	var identificador3 = PackedByteArray([17, 18, 19, 20, 21, 22, 23, 24])

	var ids = [identificador1, identificador2, identificador3]
	for id in ids:
		if binary_block_handler.block_exists(id):
			print("El identificador ya existe:", id)
		else:
			print("El identificador no existe, procediendo a guardar:", id)

	
	for id in ids:
		var data_8bit = generate_random_8bit_data()
		var data_16bit = generate_random_16bit_data()
		var data_64bit = generate_random_64bit_data()
		if not binary_block_handler.save_data_block(id, data_8bit, data_16bit, [], data_64bit):
			print("Error al guardar los datos del usuario con identificador:", id)
		else:
			print("Datos guardados correctamente para el identificador:", id)

	for id in ids:
		if binary_block_handler.block_exists(id):
			print("Confirmación: El bloque con el identificador existe:", id)
		else:
			print("Error: El bloque con el identificador no existe:", id)


func prueba_verificacion_guardado2():
	
	var binary_block_handler = BinaryBlockHandler.new("usuarios.dat", 800, 100, 0, 4)

	var identificador1 = PackedByteArray([1, 2, 3, 4, 5, 6, 7, 8])
	var identificador2 = PackedByteArray([9, 10, 11, 12, 13, 14, 15, 16])
	var identificador3 = PackedByteArray([17, 18, 19, 20, 21, 22, 23, 24])

	
	var ids = [identificador1, identificador2, identificador3]
	for id in ids:
		if binary_block_handler.block_exists(id):
			print("El identificador ya existe:", id)
		else:
			print("El identificador no existe, procediendo a guardar:", id)

	# Generar y guardar datos para los identificadores
	for id in ids:
		var data_8bit = generate_random_8bit_data()
		var data_16bit = generate_random_16bit_data()
		var data_64bit = generate_random_64bit_data()
		print("Guardando datos para el identificador:", id)
		if not binary_block_handler.save_data_block(id, data_8bit, data_16bit, [], data_64bit):
			print("Error al guardar los datos del usuario con identificador:", id)
		else:
			print("Datos guardados correctamente para el identificador:", id)
	
	for id in ids:
		print("Verificando existencia del identificador después de guardar:", id)
		if binary_block_handler.block_exists(id):
			print("Confirmación: El bloque con el identificador existe:", id)
		else:
			print("Error: El bloque con el identificador no existe:", id)
			
			
			
			
			
			
			
			
			
func prueba_completa2():
	
	var binary_block_handler = BinaryBlockHandler.new("prueba_completa.dat", 256, 255, 0, 4)  # Ajustar tamaño para data_16bit
	
	
	var all_blocks = binary_block_handler.load_all_blocks()
	if all_blocks.size() > 0:
		print("Se han cargado  (", all_blocks.size(), ")  bloques del archivo.")
		
	#return
	# Lista para almacenar los identificadores generados
	var user_identifiers = []

	for i in range(1000):
		var user_id = generate_random_identifier()
		print("Generado identificador:", user_id)
		user_identifiers.append(user_id)
		var data_8bit = generate_random_8bit_data()
		var data_16bit = generate_random_16bit_data()
		var data_64bit = generate_random_64bit_data()

		print("Guardando datos para el identificador:", user_id)
		if not binary_block_handler.save_data_block(user_id, data_8bit, data_16bit, [], data_64bit):
			print("Error al guardar los datos del usuario con identificador:", user_id)
		else:
			print("Datos guardados correctamente para el identificador:", user_id)

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
		var data_8bit = generate_random_8bit_data()
		var data_16bit = generate_random_16bit_data()
		var data_64bit = generate_random_64bit_data()

		if not binary_block_handler.save_data_block(user_id, data_8bit, data_16bit, [], data_64bit):
			print("Error al guardar los datos del usuario con identificador:", user_id)
		else:
			print("Datos guardados correctamente para el identificador:", user_id)

	# Verificar y mostrar datos de los usuarios 
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




func prueba_cocina_y_arroz():
	# Crear la instancia de BinaryBlockHandler con el archivo específico de la prueba
	var binary_block_handler = BinaryBlockHandler.new("prueba_cocina_y_arroz.dat", 256, 800, 0, 4)

	# Identificadores conocidos
	var identificador1 = PackedByteArray([1, 2, 3, 4, 5, 6, 7, 8])
	var identificador2 = PackedByteArray([9, 10, 11, 12, 13, 14, 15, 16])
	var identificador3 = PackedByteArray([17, 18, 19, 20, 21, 22, 23, 24])
	var ids = [identificador1, identificador2, identificador3]

	for id in ids:
		if binary_block_handler.block_exists(id):
			print("El identificador ya existe:", id)
		else:
			print("El identificador no existe, procediendo a guardar:", id)

	# Generar y guardar datos para los identificadores si no existen
	for id in ids:
		if not binary_block_handler.block_exists(id):
			var data_8bit = generate_random_8bit_data()
			var data_16bit = generate_random_16bit_data()
			var data_64bit = generate_random_64bit_data()
			if not binary_block_handler.save_data_block(id, data_8bit, data_16bit, [], data_64bit):
				print("Error al guardar los datos del usuario con identificador:", id)
			else:
				print("Datos guardados correctamente para el identificador:", id)

	# Seleccionar y modificar un valor específico en los datos de 8 bits y 16 bits
	for id in ids:
		var loaded_block = binary_block_handler.load_data_block(id)
		if loaded_block:
			print("Datos cargados para el identificador:", id)
			
			
			var index_8bit = 0
			var old_value_8bit = loaded_block.data_8bit[index_8bit]
			var new_value_8bit = 123  # Usar siempre el valor 123
			loaded_block.data_8bit[index_8bit] = new_value_8bit
			print("Modificado dato de 8 bits en índice", index_8bit, "de", old_value_8bit, "a", new_value_8bit)

		
			var index_16bit = 0
			var old_value_16bit = loaded_block.data_16bit[index_16bit]
			var new_value_16bit = 12345
			loaded_block.data_16bit[index_16bit] = new_value_16bit
			print("Modificado dato de 16 bits en índice", index_16bit, "de", old_value_16bit, "a", new_value_16bit)
			
			binary_block_handler.save_data_block(id, loaded_block.data_8bit, loaded_block.data_16bit, [], loaded_block.data_64bit)
		else:
			print("No se encontraron datos para el identificador:", id)

	var user_to_delete = ids[0]
	ids.remove_at(0)
	if binary_block_handler.block_exists(user_to_delete):
		if binary_block_handler.delete_data_block(user_to_delete):
			print("Eliminación exitosa para el identificador:", user_to_delete)
		else:
			print("Error al eliminar los datos del usuario con identificador:", user_to_delete)
	else:
		print("El identificador para eliminar no existe:", user_to_delete)

	# Verificamos
	for id in ids:
		print("Verificando identificador:", id)
		if binary_block_handler.block_exists(id):
			var loaded_block = binary_block_handler.load_data_block(id)
			if loaded_block:
				print("Datos cargados para el identificador:", id)
				print("Datos de 8 bits:", loaded_block.data_8bit)
				print("Datos de 16 bits:", loaded_block.data_16bit)
				print("Datos de 64 bits:", loaded_block.data_64bit)
			else:
				print("No se encontraron datos para el identificador:", id)
		else:
			print("Confirmación: El bloque con el identificador ha sido eliminado:", id)





func tengo_hambre():

	var binary_block_handler = BinaryBlockHandler.new("tengo_hambre.dat", 256, 255, 0, 4)


	var ids = [
		PackedByteArray([1, 2, 3, 4, 5, 6, 7, 8]),
		PackedByteArray([9, 10, 11, 12, 13, 14, 15, 16]),
		PackedByteArray([17, 18, 19, 20, 21, 22, 23, 24]),
		PackedByteArray([25, 26, 27, 28, 29, 30, 31, 32]),
		PackedByteArray([33, 34, 35, 36, 37, 38, 39, 40]),
		PackedByteArray([41, 42, 43, 44, 45, 46, 47, 48]),
		PackedByteArray([49, 50, 51, 52, 53, 54, 55, 56]),
		PackedByteArray([57, 58, 59, 60, 61, 62, 63, 64]),
		PackedByteArray([65, 66, 67, 68, 69, 70, 71, 72]),
		PackedByteArray([73, 74, 75, 76, 77, 78, 79, 80])
	]

	# 10 veces
	for cycle in range(10):
		print("Ciclo:", cycle + 1)

		
		for id in ids:
			var data_8bit = generate_random_8bit_data()
			var data_16bit = generate_random_16bit_data()
			var data_64bit = generate_random_64bit_data()
			if not binary_block_handler.save_data_block(id, data_8bit, data_16bit, [], data_64bit):
				print("Error al guardar los datos del usuario con identificador:", id)
			else:
				print("Datos guardados correctamente para el identificador:", id)

		# Eliminar los primeros 4 usuarios
		for i in range(4):
			var id_to_delete = ids[i]
			if binary_block_handler.block_exists(id_to_delete):
				if binary_block_handler.delete_data_block(id_to_delete):
					print("Eliminación exitosa para el identificador:", id_to_delete)
				else:
					print("Error al eliminar los datos del usuario con identificador:", id_to_delete)
			else:
				print("El identificador para eliminar no existe:", id_to_delete)

		# Guardar nuevamente los identificadores restantes para verificar si usan el espacio vacío
		for id in ids:
			var data_8bit = generate_random_8bit_data()
			var data_16bit = generate_random_16bit_data()
			var data_64bit = generate_random_64bit_data()
			if not binary_block_handler.save_data_block(id, data_8bit, data_16bit, [], data_64bit):
				print("Error al guardar los datos del usuario con identificador:", id)
			else:
				print("Datos guardados correctamente para el identificador:", id)



#
#func canto_de_pajaros():
	## Crear la instancia de BinaryBlockHandler con el archivo específico de la prueba
	#var binary_block_handler = BinaryBlockHandler.new("canto_de_pajaros.dat", 256, 255, 0, 4)
#
	## Identificadores conocidos
	#var identificador1 = PackedByteArray([1, 2, 3, 4, 5, 6, 7, 8])
#
	## Verificar si el identificador existe antes de guardar
	#if binary_block_handler.block_exists(identificador1):
		#print("El identificador ya existe:", identificador1)
		#var loaded_block = binary_block_handler.load_data_block(identificador1)
		#if loaded_block:
			#print("Datos cargados para el identificador:", identificador1)
			#print("Datos de 8 bits antes de modificar:", loaded_block.data_8bit)
			#
			## Modificar los valores de 8 bits en las posiciones 0 y 34 a valores aleatorios
			#loaded_block.data_8bit[0] = randi() % 256
			#loaded_block.data_8bit[34] = randi() % 256
			#print("Datos de 8 bits después de modificar:", loaded_block.data_8bit)
			#
			## Guardar los cambios
			#if binary_block_handler.save_data_block(identificador1, loaded_block.data_8bit, loaded_block.data_16bit, [], loaded_block.data_64bit):
				#print("Datos modificados y guardados correctamente para el identificador:", identificador1)
			#else:
				#print("Error al guardar los datos del usuario con identificador:", identificador1)
		#else:
			#print("Error al cargar los datos del usuario con identificador:", identificador1)
	#else:
		#print("El identificador no existe, procediendo a guardar:", identificador1)
		#var data_8bit = generate_random_8bit_data()
		#var data_16bit = generate_random_16bit_data()
		#var data_64bit = generate_random_64bit_data()
		#if binary_block_handler.save_data_block(identificador1, data_8bit, data_16bit, [], data_64bit):
			#print("Datos guardados correctamente para el identificador:", identificador1)
		#else:
			#print("Error al guardar los datos del usuario con identificador:", identificador1)
#
##


func canto_de_pajaros():
	# Crear la instancia de BinaryBlockHandler con el archivo específico de la prueba
	var binary_block_handler = BinaryBlockHandler.new("canto_de_pajaros.dat", 256, 255, 0, 4)

	# Cargar todos los bloques existentes en el archivo
	var all_blocks = binary_block_handler.load_all_blocks()
	if all_blocks.size() > 0:
		print("Se han cargado  (", all_blocks.size(), ")  bloques del archivo.")
		
		# Iterar sobre los bloques y mostrar su información
		for block in all_blocks:
			print("Identificador:", block.identifier)
			print("Datos de 8 bits:", block.data_8bit)
			print("Datos de 16 bits:", block.data_16bit)
			print("Datos de 64 bits:", block.data_64bit)
	else:
		print("No se encontraron bloques en el archivo.")

	# Identificadores conocidos
	var identificador1 = PackedByteArray([1, 2, 3, 4, 5, 6, 7, 8])

	# Verificar si el identificador existe antes de guardar
	if binary_block_handler.block_exists(identificador1):
		print("El identificador ya existe:", identificador1)
		var loaded_block = binary_block_handler.load_data_block(identificador1)
		if loaded_block:
			print("Datos cargados para el identificador:", identificador1)
			print("Datos de 8 bits antes de modificar:", loaded_block.data_8bit)

			# Modificar los valores de 8 bits en las posiciones 0 y 34 a valores aleatorios
			if loaded_block.data_8bit.size() > 34:
				loaded_block.data_8bit[0] = randi() % 256
				loaded_block.data_8bit[34] = randi() % 256
				print("Datos de 8 bits después de modificar:", loaded_block.data_8bit)

				# Guardar los cambios
				if binary_block_handler.save_data_block(identificador1, loaded_block.data_8bit, loaded_block.data_16bit, [], loaded_block.data_64bit):
					print("Datos modificados y guardados correctamente para el identificador:", identificador1)
				else:
					print("Error al guardar los datos del usuario con identificador:", identificador1)
			else:
				print("El bloque no tiene suficientes datos de 8 bits para modificar las posiciones 0 y 34.")
		else:
			print("Error al cargar los datos del usuario con identificador:", identificador1)
	else:
		print("El identificador no existe, procediendo a guardar:", identificador1)

		# Generar nuevos datos aleatorios
		var data_8bit = generate_random_8bit_data()
		var data_16bit = generate_random_16bit_data()
		var data_64bit = generate_random_64bit_data()

		# Guardar los nuevos datos
		if binary_block_handler.save_data_block(identificador1, data_8bit, data_16bit, [], data_64bit):
			print("Datos guardados correctamente para el identificador:", identificador1)
		else:
			print("Error al guardar los datos del usuario con identificador:", identificador1)
