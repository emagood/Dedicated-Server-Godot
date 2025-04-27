'''






'''


extends Control

var user_identifiers = []
var binary_block_handler = null
@onready var log = $ScrollContainer/log_scroll
	
var data_8bit
var data_16bit
var data_64bit


func _ready() -> void:
	data_8bit = generate_random_8bit_data(256)
	data_16bit = generate_random_16bit_data(255)
	data_64bit = generate_random_64bit_data(4)
	var array_string = string_to_packedbytearray("1234567890")
	label_log(array_string)
	var name = "kijkonh"
	var adjusted = nick_name(name)
	label_log("Nombre ajustado:"+ str(adjusted) +"size (" + str(adjusted.length()) + ")")

	
	
	
	pass
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
func label_log(stra):
	log.texto += str(stra) + "\n"

#func string_to_packedbytearray(identifier_str: String) -> PackedByteArray:
	#var packed_identifier = PackedByteArray()
	#
	## Verifica que el string tenga exactamente 16 caracteres
	#if identifier_str.length() != 16:
		#print("Error: El identificador debe tener exactamente 16 caracteres.")
		#return PackedByteArray() # Retorna un array vacío si no tiene 16 caracteres
	#
	## Procesa cada carácter del string y lo convierte en un byte
	#for char in identifier_str:
		## Utiliza to_ascii_buffer() para obtener el valor ASCII del carácter
		#var ascii_byte = char.to_ascii_buffer()[0] # Obtén el primer byte de la representación ASCII
		#packed_identifier.append(ascii_byte)
#
	#return packed_identifier

func string_to_packedbytearray(identifier_str: String) -> PackedByteArray:
	var packed_identifier = PackedByteArray()

	# Rellenar el string con espacios si es menor a 16 caracteres
	if identifier_str.length() < 16:
		var spaces_to_add = 16 - identifier_str.length()
		identifier_str += " ".repeat(spaces_to_add) # Genera los espacios necesarios usando repeat()
	else:
		prints("error el strin muy largo")
		return PackedByteArray([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
	# Procesa cada carácter del string rellenado como un byte
	for char in identifier_str:
		var ascii_byte = char.to_ascii_buffer()[0] # Obtén el valor ASCII del carácter
		packed_identifier.append(ascii_byte)
	prints(packed_identifier)
	return packed_identifier



#func string_to_packedbytearray(identifier_str: String) -> PackedByteArray:
	#var identifier = int(identifier_str)
	#var packed_identifier = PackedByteArray()
	#label_log(str(identifier) + " " + "identififador")
	#for i in range(16):
		## Extrae cada byte del número de 64 bits
		#packed_identifier.append((identifier >> (8 * (15 - i))) & 0xFF)
#
	#return packed_identifier



func generate_random_identifier() -> PackedByteArray:
	var identifier = PackedByteArray()
	for i in range(16):
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
	
	binary_block_handler = BinaryBlockHandler.new("prueba_completa.dat", 256, 255, 0, 0)  # Ajustar tamaño para data_16bit
	
	var timer_local = Time.get_ticks_msec()
	#var timer_local2 = timer_local
	#prints("Tiempo inicial: " + str(Time.get_ticks_msec()))
	var all_blocks = binary_block_handler.load_all_blocks()
	if all_blocks.size() > 0:
		print("Se han cargado  (", all_blocks.size(), ")  bloques del archivo. en milisegundos (" , Time.get_ticks_msec() - timer_local ,") ")
	
	#return
	# Lista para almacenar los identificadores generados  8 256 510 774
	user_identifiers = []
 
	for i in range(1000):
		var user_id = generate_random_identifier()
		print("Generado identificador:", user_id)
		user_identifiers.append(user_id)
		var data_8bit = generate_random_8bit_data(256)
		var data_16bit = generate_random_16bit_data(255)
		#var data_64bit = generate_random_64bit_data(4)

		print("Guardando datos para el identificador:", user_id)
		if not binary_block_handler.save_data_block(user_id, data_8bit, data_16bit, [],[]):
			print("Error al guardar los datos del usuario con identificador:", user_id)
		else:
			print("Datos guardados correctamente para el identificador:", user_id)
			
	for user_id in user_identifiers:
		var sample_string = "Hello, Binary! mi nombre es emanuel y el tuyo ??"
		binary_block_handler.save_string(user_id, 0, sample_string)
		print("String guardado en el bloque de 8 bits:", sample_string)
		
	for user_id in user_identifiers:
		var result_string = binary_block_handler.read_string(user_id, 8,  28)
		print("String leído desde el bloque de 8 bits, posiciones 1 a 20:", result_string)
#
	##prints(binary_block_handler.index)




	for user_id in user_identifiers:
		print("Verificando identificador:", user_id)
		var loaded_block = binary_block_handler.load_data_block(user_id)
		if loaded_block:
			print("Datos cargados para el identificador:", user_id)
			print("Datos de 8 bits:", loaded_block.data_8bit)
			print("Datos de 16 bits:", loaded_block.data_16bit)
			#print("Datos de 64 bits:", loaded_block.data_64bit)
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
		#var data_64bit = generate_random_64bit_data(4)

		if not binary_block_handler.save_data_block(user_id, data_8bit, data_16bit, [], []):
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


func _on__identificadores_pressed() -> void:
	if binary_block_handler == null:
		label_log("error no se puede argar iniialisa primero")
		return
	var timer_local = Time.get_ticks_msec()
	var adduser = int(str($adduser.text))
	#prints(adduser)
	#return
	for i in range(adduser):
		var user_id = generate_random_identifier()
		label_log("Generado identificador:"+ str(user_id))
		user_identifiers.append(user_id)
		#var data_8bit = generate_random_8bit_data(256)
		#var data_16bit = generate_random_16bit_data(255)
		#var data_64bit = generate_random_64bit_data(4)
		#prints(data_8bit , " datos de 8 bit ema prueba total")
		label_log("Guardando datos para el identificador:"+ str(user_id))
		if not binary_block_handler.save_data_block(user_id, data_8bit, data_16bit, [], []):
			label_log("Error al guardar los datos del usuario con identificador:"+ str(user_id))
		else:
			label_log("Datos guardados correctamente para el identificador:"+ str(user_id))
			
	#pass # Replace with function body.

	print(adduser, ": user listos no aleatorios .(generate_random_identifier()) en milisegundos (" , Time.get_ticks_msec() - timer_local ,") ")
	#timer_local = Time.get_ticks_msec()
	#for i in range(10):
		#var user_id = generate_random_identifier()
		#print("Generado identificador:", user_id)
		#user_identifiers.append(user_id)
		#var data_8bit = generate_random_8bit_data(256)
		#var data_16bit = generate_random_16bit_data(255)
		##var data_64bit = generate_random_64bit_data(4)
		#prints(data_8bit , " datos de 8 bit ema prueba total")
		#print("Guardando datos para el identificador:", user_id)
		#if not binary_block_handler.save_data_block(user_id, data_8bit, data_16bit, [], []):
			#print("Error al guardar los datos del usuario con identificador:", user_id)
		#else:
			#print("Datos guardados correctamente para el identificador:", user_id)
	#print(" 20 user listos aleatorios.(generate_random_identifier()) en milisegundos (" , Time.get_ticks_msec() - timer_local ,") ")


func _on_data_random_id_pressed() -> void:
	if binary_block_handler == null:
		label_log("error no se puede argar iniialisa primero")
		return
	var total = 5
	for user_id in user_identifiers:
		total-= 1
		print("Verificando identificador:", user_id)
		var loaded_block = binary_block_handler.load_data_block(user_id)
		if loaded_block:
			print("Datos cargados para el identificador:", user_id)
			print("Datos de 8 bits:", loaded_block.data_8bit)
			print("Datos de 16 bits:", loaded_block.data_16bit)
			#print("Datos de 64 bits:", loaded_block.data_64bit)
		else:
			print("No se encontraron datos para el identificador:", user_id)

		


		user_identifiers.append(user_id)
		var data_8bit = generate_random_8bit_data(256)
		var data_16bit = generate_random_16bit_data(255)
		#var data_64bit = generate_random_64bit_data(4)

		binary_block_handler.save_data_block(user_id, data_8bit, data_16bit, [],[])
		label_log(str(loaded_block.data_8bit.size() )+" " +"  este es el bloque de  8 bit de memoria")
		label_log(str(loaded_block.data_16bit.size())+ " " + "  este es el bloque de  16 bit de memoria")
		#binary_block_handler.load_data_block(user_id)
		#print("Datos cargados para el identificador:", user_id)
		#print("Datos de 8 bits:", loaded_block.data_8bit)
		#print("Datos de 16 bits:", loaded_block.data_16bit)
		#
		if total <= 0:
			return
		
	pass # Replace with function body.


func _on_string_data_pressed() -> void:
	if binary_block_handler == null:
		label_log("error no se puede argar iniialisa primero")
		return
	
	
	
	
	for user_id in user_identifiers:
		
		var sample_string = nick_name("my_name_is_ema")
		binary_block_handler.save_string(user_id, 0, sample_string)
		print("String guardado en el bloque de 8 bits:", sample_string)
		

		var result_string = binary_block_handler.read_string(user_id, 0,  20)
		print("String leído desde el bloque de 8 bits, posiciones 1 a 20:", result_string) # Replace with function body.


func _on_delete_1k_pressed() -> void:
	if binary_block_handler == null:
		label_log("error no se puede argar iniialisa primero")
		return
	# Eliminar datos de los usuarios
	var total = 0
	for user_id in user_identifiers:
		if total >= 1000:
			return
		total += 1
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

	pass # Replace with function body.


func _on_count_user_pressed() -> void:
	if binary_block_handler == null:
		label_log("error no se puede argar iniialisa primero")
		return
	var timer_local = Time.get_ticks_msec()
	var all_blocks = binary_block_handler.load_all_blocks()
	if all_blocks.size() > 0:
		print("Se han cargado  (", all_blocks.size(), ")  bloques del archivo. en milisegundos (" , Time.get_ticks_msec() - timer_local ,") ")
	#label_log(user_identifiers)
	#label_log(all_blocks)
	user_identifiers = all_blocks.duplicate()
	# probando multiples archivos
	
	timer_local = Time.get_ticks_msec()
	var num_files = 4 # Número configurable de archivos a abrir
	var total_identifiers = binary_block_handler.count_valid_identifiers(num_files)
	print("Total de identificadores válidos:", total_identifiers)
	print("Se han cargado  (", total_identifiers, ")  bloques del archivo multiples. en milisegundos (" , Time.get_ticks_msec() - timer_local ,") ")
	#label_log(user_identifiers)
	pass # Replace with function body.




# Función para ajustar un nombre a 20 caracteres
func nick_name(name: String) -> String:
	var max_length = 20

	if name.length() > max_length:
		print("El nombre es demasiado largo. Máximo permitido son 20 caracteres.")
		return ""
	elif name.length() < max_length:
		# Añadir espacios al final hasta que la longitud sea de 20 caracteres
		while name.length() < max_length:
			name += " "
	return name


func _on_buscar_desde_pressed() -> void:
	if binary_block_handler == null:
		label_log("error no se puede argar iniialisa primero")
		return
	var timer_local = Time.get_ticks_msec()
	var start_block = 0
	var max_blocks = 10
	var blocks = binary_block_handler.load_blocks_from(start_block, max_blocks)
	print("Bloques cargados desde el bloque ", start_block)  #, ":", blocks


	for user_id in user_identifiers:
		timer_local = Time.get_ticks_msec()
		#prints("prueba de busqueda ")
		start_block = 0
		var identifier = user_id  # Reemplaza con tu identificador
		var position = binary_block_handler.find_identifier_from(start_block, identifier,max_blocks)
		if position != -1:
			print("Identificador encontrado en la posición:", position)
		else:
			print("Identificador no encontrado desde el bloque ", start_block)
		#return
		#print(" bloques del archivo.(find_identifier_from) en milisegundos (" , Time.get_ticks_msec() - timer_local ,") ")


		#timer_local = Time.get_ticks_msec()
		var num_files = 4  # Número configurable de archivos a abrir
		position = binary_block_handler.multi_identifier_file(identifier, num_files)
		if position != -1:
			print("Identificador encontrado en la posición multi file :", position)
		else:
			print("Identificador no encontrado en los sectores divididos entre", num_files, "archivos")
			
		print(" bloques del archivo.(multi_identifier_file) en milisegundos (" , Time.get_ticks_msec() - timer_local ,") ")

pass # Replace with function body.


func _on_user_1_pressed() -> void:
	if binary_block_handler == null:
		label_log("error no se puede argar iniialisa primero")
		return

	for i in range(1):
		var user_id = generate_random_identifier()
		print("Generado identificador:", user_id)
		user_identifiers.append(user_id)
		var data_8bit = generate_random_8bit_data(256)
		var data_16bit = generate_random_16bit_data(255)
		#var data_64bit = generate_random_64bit_data(4)
		label_log(str(data_8bit)+" " +" datos de 8 bit ema prueba total")
		label_log("Guardando datos para el identificador:" + " :" + str( user_id))
		if not binary_block_handler.save_data_block(user_id, data_8bit, data_16bit, [], []):
			label_log("Error al guardar los datos del usuario con identificador:"+": " +str(user_id))
		else:
			label_log("Datos guardados correctamente para el identificador:"+ " " + str( user_id))
			
	pass # Replace with function body.


	pass # Replace with function body.


func _on_salir_pressed() -> void:
	queue_free()
	pass # Replace with function body.


func _on_speed_search_pressed() -> void:
	var timer_local = Time.get_ticks_msec()
	if binary_block_handler == null:
		label_log("error no se puede argar iniialisa primero")
		return


	for user_id in user_identifiers:
		#prints("prueba de busqueda ")
		var identifier = user_id  # Reemplaza con tu identificador
		
		timer_local = Time.get_ticks_msec()
		var num_files = 2 # Número configurable de archivos a abrir
		var position = binary_block_handler.multi_identifier_file(identifier, num_files)
		if position != -1:
			label_log("Identificador encontrado en la posición multi file : "+ str(position))
		else:
			label_log("Identificador no encontrado en los sectores divididos entre " + str(num_files) + " archivos")
			
		print(" bloques del archivo.(multi_identifier_file) en milisegundos (" , Time.get_ticks_msec() - timer_local ,") ")

	pass # Replace with function body.


func _on_block_exist_pressed() -> void:
	if binary_block_handler == null:
		label_log("error no se puede argar iniialisa primero")
		return
	var timer_local = Time.get_ticks_msec()
	var count = 0
	for user_id in user_identifiers:
		count += 1
		timer_local = Time.get_ticks_msec()
		if binary_block_handler.block_exists(user_id):
			label_log(" bloques del archivo.(block exist) en milisegundos (" + str(Time.get_ticks_msec() - timer_local ) + ") user id = " + str(user_id) + " user position =  " + str(count))

	pass # Replace with function body.


func _on_prueba_add_use_exist_pressed() -> void:
	if binary_block_handler == null:
		label_log("error no se puede argar iniialisa primero")
		return
	var user_id = string_to_packedbytearray("1234567890123")
	print("Generado identificador:", user_id)
	user_identifiers.append(user_id)
	var data_8bit = generate_random_8bit_data(256)
	var data_16bit = generate_random_16bit_data(255)
	#var data_64bit = generate_random_64bit_data(4)
	label_log(str(data_8bit )+ " datos de 8 bit ema prueba total")
	label_log("Guardando datos para el identificador:" + str(user_id))
	if not binary_block_handler.save_data_block(user_id, data_8bit, data_16bit, [], []):
		print("Error al guardar los datos del usuario con identificador:", user_id)
	else:
		print("Datos guardados correctamente para el identificador:", user_id)
			
	pass # Replace with function body.


	pass # Replace with function body.


func _on_user_0_pressed() -> void:
	if binary_block_handler == null:
		label_log("error no se puede argar iniialisa primero")
		return
	var user_id = string_to_packedbytearray("emanuel") ## /// da (0) / 0
	print("Generado identificador:", user_id)
	user_identifiers.append(user_id)
	var data_8bit = generate_random_8bit_data(256)
	var data_16bit = generate_random_16bit_data(255)
	#var data_64bit = generate_random_64bit_data(4)
	#prints(data_8bit , " datos de 8 bit ema prueba total")
	print("Guardando datos para el identificador:", user_id)
	if not binary_block_handler.save_data_block(user_id, data_8bit, data_16bit, [], []):
		print("Error al guardar los datos del usuario con identificador:", user_id)
	else:
		print("Datos guardados correctamente para el identificador:", user_id)
			

	var loaded_block = binary_block_handler.load_data_block(user_id)
	if loaded_block:
		print("Datos cargados para el identificador:", user_id)
		print("Datos de 8 bits:", loaded_block.data_8bit)
		print("Datos de 16 bits:", loaded_block.data_16bit)
			#print("Datos de 64 bits:", loaded_block.data_64bit)
	else:
		print("No se encontraron datos para el identificador:", user_id)
	pass # Replace with function body.
	pass # Replace with function body.


func _on_test_id_speed_pressed() -> void:
	if binary_block_handler == null:
		label_log("error no se puede argar iniialisa primero")
		return
	var timer_local = Time.get_ticks_msec()
	var count = 0
	var user
	for user_id in user_identifiers:
		count += 1
		user = user_id
		if count >= 5000:
			break
		#timer_local = Time.get_ticks_msec()
	label_log(str(user) + " identificasdor user no se algo de eso ")
	if binary_block_handler.load_index_blocks(user):
		
		label_log(" bloques del archivo.(load_index_blocks) en milisegundos (" +str( Time.get_ticks_msec() - timer_local ) + ") user id = " + str(user) + " user position =  " + str(count))
	timer_local = Time.get_ticks_msec()
	if binary_block_handler.block_exists(user):
		label_log(" bloques del archivo.(block exists) en milisegundos (" +str( Time.get_ticks_msec() - timer_local ) + ") user id = " + str(user) + " user position =  " + str(count))

	pass # Replace with function body.load_index_blocks

	pass # Replace with function body.


func _on_aad_user_manueal_pressed() -> void:
	if binary_block_handler == null:
		label_log("error no se puede argar iniialisa primero")
		return
	if $"aad_user manueal/add_id".text == "":
		label_log("error ingrese un string valido ")
		return
	var user_id =  string_to_packedbytearray($"aad_user manueal/add_id".text)  #generate_random_identifier()
	var temp_user
	prints("desde user add: " ,user_id)
	var data_8bit = generate_random_8bit_data(256)
	var data_16bit = generate_random_16bit_data(255)
	#var data_64bit = generate_random_64bit_data(4)
	#prints(data_8bit , " datos de 8 bit ema prueba total")
	label_log("Guardando datos para el identificador:"+ str( user_id))
	if not binary_block_handler.save_data_block(user_id, data_8bit, data_16bit, [], []):
		label_log("Error al guardar los datos del usuario con identificador:"+str( user_id))
	else:
		label_log("Datos guardados correctamente para el identificador:" + str(user_id))




func _on_exist_manual_pressed() -> void:
	if binary_block_handler == null:
		label_log("error no se puede argar iniialisa primero")
		return
	if $exist_manual/id_search.text == "":
		label_log("error ingrese un string valido ")
		return
	var user_id = string_to_packedbytearray($exist_manual/id_search.text)
	var loaded_block = binary_block_handler.block_exists(user_id)
	if loaded_block:
		print("El usuario existe :", user_id)
		#print("Datos de 8 bits:", loaded_block.data_8bit)
		#print("Datos de 16 bits:", loaded_block.data_16bit)
		#print("Datos de 64 bits:", loaded_block)
	else:
		print("No se encontraron datos para el identificador:", user_id)
			


func _on_load_manual_pressed() -> void:
	if binary_block_handler == null:
		label_log("error no se puede argar iniialisa primero")
		return
	if $load_manual/load_data_id.text == "":
		label_log("error ingrese un string valido ")
		return
	var user_id = string_to_packedbytearray($load_manual/load_data_id.text)
	var loaded_block = binary_block_handler.load_data_block(user_id)
	if loaded_block:
		print("El usuario data existe :", user_id)
		print("Datos de 8 bits:", loaded_block.data_8bit)
		print("Datos de 16 bits:", loaded_block.data_16bit)
		#print("Datos de 64 bits:", loaded_block)
	else:
		print("No se encontraron datos para el identificador:", user_id)
			

func _on_init_database_pressed() -> void:
	if binary_block_handler != null:
		#binary_block_handler.queue_free()
		label_log("clase ya iniciada configuracion: archivo "+ str(binary_block_handler.filename) + " size 8: " + str(binary_block_handler.size_8bit) + " size 16: " + str(binary_block_handler.size_16bit) + " size 32: "+ str(binary_block_handler.size_32bit) + " size 64: "+ str(binary_block_handler.size_64bit))
		return
		
	binary_block_handler = BinaryBlockHandler.new($init_database/file.text,int($init_database/n8bit.text), int($init_database/n16bit.text), int($init_database/n32bit.text), int($init_database/n64bit.text))
	add_child(binary_block_handler)
	 # Ajustar tamaño para data_16bit
	pass # Replace with function body.


func _on_quit_class_pressed() -> void:
	if binary_block_handler != null:
		binary_block_handler.queue_free()
		binary_block_handler = null
		label_log("se elimino la clase")
	else:
		label_log("no se nicio la clase")
	pass # Replace with function body.
