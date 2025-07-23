extends Control
var number1 = []
var archivo := "user://demo.bin"
var valor := 5  # Byte clave para verificar
var bite =  []
var result = PackedByteArray()



func _ready():
	prints("READY")


	#region mm
	#crear_archivo_demo(archivo, 20)
	#await get_tree().process_frame
#
	#var real_size := obtener_tamano_archivo(archivo)
	#if real_size < 0:
		#return
#
	## Definición de bloques nuevos
	#var head := PackedByteArray([100, 101, 102, 103])
	#var tail := PackedByteArray([250, 251, 252])
#
	## Offsets dinámicos
	#var head_len := head.size()
	#var tail_len := tail.size()
	#var middle_offset := head_len
	#var middle_len := real_size - head_len - tail_len
	#if middle_len < 0:
		#push_error("El archivo es más chico que head + tail")
		#return
#
	## Construcción del bloque middle
	#var middle := PackedByteArray()
	#for i in range(middle_len):
		#middle.append(99)
#
	## Lectura original de secciones
	#var head_original := leer_seccion(archivo, 0, head_len)
	#var middle_original := leer_seccion(archivo, middle_offset, middle_len)
	#var tail_original := leer_seccion(archivo, real_size - tail_len, tail_len)
#
	## Parchear archivo
	#patch_file_flexible(archivo, head, tail, false, middle, valor)
#
	## Lectura modificada de secciones
	#var head_modificado := leer_seccion(archivo, 0, head_len)
	#var middle_modificado := leer_seccion(archivo, middle_offset, middle_len)
	#var tail_modificado := leer_seccion(archivo, real_size - tail_len, tail_len)
#
	#print("HEAD final:", head_modificado)
	#print("MIDDLE final:", middle_modificado)
	#print("TAIL final:", tail_modificado)
#
	#comparar_seccion("HEAD", head_original, head_modificado)
	#comparar_seccion("MIDDLE", middle_original, middle_modificado)
	#comparar_seccion("TAIL", tail_original, tail_modificado)
#endregion


func crear_archivo_demo(path: String, size: int):
	var datos := PackedByteArray()
	for i in range(size):
		datos.append(i)

	var f := FileAccess.open(path, FileAccess.WRITE)
	if f == null:
		push_error("No se pudo crear el archivo")
		return
	f.store_buffer(datos)
	f.flush()
	f.close()
	print("✅ Archivo creado con %d bytes en: %s" % [size, path])


func obtener_tamano_archivo(path: String) -> int:
	var f := FileAccess.open(path, FileAccess.READ)
	prints(path)
	if f == null:
		push_error("No se pudo abrir el archivo para obtener su tamaño")
		return -1
	var len := f.get_length()
	f.close()
	return len


func leer_seccion(path: String, offset: int, cantidad: int) -> PackedByteArray:
	var f := FileAccess.open(path, FileAccess.READ)
	if f == null:
		push_error("No se pudo leer el archivo")
		return PackedByteArray()
	f.seek(offset)
	var buffer := f.get_buffer(cantidad)
	f.close()
	return buffer


func comparar_seccion(etiqueta: String, original: PackedByteArray, modificado: PackedByteArray):
	var cambios := []
	for i in range(min(original.size(), modificado.size())):
		if original[i] != modificado[i]:
			cambios.append("Offset %02d: %d → %d" % [i, original[i], modificado[i]])
	if cambios.is_empty():
		print("✅ %s sin cambios detectados" % etiqueta)
	else:
		print("⚠️ Cambios en %s:" % etiqueta)
		for cambio in cambios:
			print("   ", cambio)


func patch_file_flexible(
	path: String,
	new_head: PackedByteArray,
	new_tail: PackedByteArray,
	write_middle := false,
	new_middle: PackedByteArray = PackedByteArray(),
	valor: int = 5
):
	
	var f := FileAccess.open(path, FileAccess.READ_WRITE)
	if f == null:
		push_error("No se pudo abrir el archivo para modificar")
		return

	var size := f.get_length()
	var head_len := new_head.size()
	var tail_len := new_tail.size()
	var middle_len := size - head_len - tail_len

	if head_len + tail_len > size:
		push_error("HEAD + TAIL exceden tamaño del archivo: %d + %d > %d" % [head_len, tail_len, size])
		f.close()
		return

	var contiene_byte_valor := func(offset: int, cantidad: int, etiqueta: int) -> void:
		#result = []
		f.seek(offset)
		var datos := f.get_buffer(cantidad)
		for b in datos:
			if b == valor:
				print("⚠️ Byte %d encontrado en sección ID=%d" % [valor, etiqueta])
				break
		var num1 = []
		var num2 = []
		var operation
		if $CheckButton.button_pressed:
			operation = "xor"
			num1 = datos
			num2 = number1
		else:
			operation = "xor"
			num2 = datos
			num1 = number1


		if result.size() >= $HSlider.value:
			result = []
		for i in range(num1.size()):
			var byte1 = num1[i]
			var byte2 = num2[i]
			var res = 0
			match operation:
				"xor":
					res = byte1 ^ byte2
				"and":
					res = byte1 & byte2
				"or":
					res = byte1 | byte2
				"nand":
					res = ~(byte1 & byte2) & 0xFF
				"nor":
					res = ~(byte1 | byte2) & 0xFF
				"xnor":
					res = ~(byte1 ^ byte2) & 0xFF
			result.append(res)



				
				
				
				


	# HEAD (ID 1)
	contiene_byte_valor.call(0, head_len, 1)
	f.seek(0)
	new_head = result
	prints("prueba",new_head)
	f.store_buffer(new_head)

	# MIDDLE (ID 2)
	if write_middle:
		if new_middle.size() != middle_len:
			push_error("Bloque medio inválido: esperado=%d, recibido=%d" % [middle_len, new_middle.size()])
			f.close()
			return
		contiene_byte_valor.call(head_len, middle_len, 2)
		f.seek(head_len)
		f.store_buffer(new_middle)

	# TAIL (ID 3)
	
	contiene_byte_valor.call(size - tail_len, tail_len, 3)
	f.seek(size - tail_len)
	var h = new_tail.size()
	new_tail = result
	var g = new_tail.size()
	var j = result.size()
	
	
	f.store_buffer(new_tail)

	f.close()
	print("✅ Parche aplicado (verificación con byte =", valor, ")")

func encode(archivo , seed):
	var my_seed = $LineEdit.text.hash()
	seed(my_seed)
	number1 = []
	#crear_archivo_demo(archivo, 20)
	#await get_tree().process_frame
	for i in range($HSlider.value):
		number1.append(randi() % 256)
		#number1.append(generate_random_8byte_number())
		
	push_error("number=%d" % [number1.size()])
	prints("numeropi",number1)
	
	
	var real_size := obtener_tamano_archivo(archivo)
	if real_size < 0:
		return

	# Definición de bloques nuevos
	var head = number1
	var tail = number1

	# Offsets dinámicos
	var head_len := head.size()
	var tail_len := tail.size()
	var middle_offset := head_len
	var middle_len := real_size - head_len - tail_len
	if middle_len < 0:
		push_error("El archivo es más chico que head + tail")
		return

	# Construcción del bloque middle
	var middle := PackedByteArray()
	#for i in range(middle_len):
		#middle.append(99)

	## Lectura original de secciones
	#var head_original := leer_seccion(archivo, 0, head_len)
	#var middle_original := leer_seccion(archivo, middle_offset, middle_len)
	#var tail_original := leer_seccion(archivo, real_size - tail_len, tail_len)

	# Parchear archivo
	patch_file_flexible(archivo, head, tail, false, middle, valor)

	## Lectura modificada de secciones
	#var head_modificado := leer_seccion(archivo, 0, head_len)
	#var middle_modificado := leer_seccion(archivo, middle_offset, middle_len)
	#var tail_modificado := leer_seccion(archivo, real_size - tail_len, tail_len)
#
	#print("HEAD final:", head_modificado)
	#print("MIDDLE final:", middle_modificado)
	#print("TAIL final:", tail_modificado)

	#comparar_seccion("HEAD", head_original, head_modificado)
	#comparar_seccion("MIDDLE", middle_original, middle_modificado)
	#comparar_seccion("TAIL", tail_original, tail_modificado)
#
#






func _on_file_dialog_dir_selected(diro: String) -> void:
	
	var directory_path = diro
	var dir = DirAccess.open(diro)
	if dir:
		dir.list_dir_begin()
		while true:
			var file_name = dir.get_next()
			if file_name == "":
				break
			if !dir.current_is_dir():
				prints(directory_path +"/"+ file_name)#encrypt_and_rename(directory_path + file_name, key, iv)
				encode(directory_path +"/"+ file_name , 1235)
				result = PackedByteArray()
		dir.list_dir_end()
	prints("Archivos correctamente.")
	


func generate_random_8byte_number() -> PackedByteArray:
	var number = PackedByteArray()
	for i in range(8):
		number.append(randi() % 256)
	return number


func _on_open_pressed() -> void:
	$FileDialog.visible = true
	pass # Replace with function body.


func _on_h_slider_drag_ended(value_changed: bool) -> void:
	$HSlider/Label.text = str($HSlider.value)
	pass # Replace with function body.


func _on_h_slider_drag_started() -> void:
	$HSlider/Label.text = str($HSlider.value)
	pass # Replace with function body.
