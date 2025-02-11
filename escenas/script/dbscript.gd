extends User_tool


'''
quitar lineas absurdas 



'''





#
#
#
#class UserSearcher:
	#var filename: String
#
	#func _init(filename: String):
	
		#self.filename = filename
#
	#func read_partial(file, length: int) -> String:
		#return file.get_buffer(length).get_string_from_utf8().strip_edges()
#
	#func find_user_by_identifier(identifier: String) -> Dictionary:
		#var file = FileAccess.open(filename, FileAccess.READ)
		#if not file:
			#print("Error al abrir el archivo de usuarios.")
			#return {}
#
		#while file.get_position() < file.get_length():
			#var initial_position = file.get_position()
			#file.get_buffer(16)  # Saltar el nombre de usuario
#
			#if read_partial(file, 16) == identifier:
				#file.seek(initial_position)
				#var user_string = file.get_buffer(36).get_string_from_utf8()
				#file.close()
				#return User.from_string(user_string).to_dict()
#
			#file.seek(initial_position + 36)
#
		#file.close()
		##print("El usuario no existe: ", identifier)
		##return {}
##
##
#class UserSearcher:
	#var filename: String
#
	#func _init(filename: String):
		#self.filename = filename
#
	#func read_partial(file: FileAccess, length: int) -> String:
		#return file.get_buffer(length).get_string_from_utf8().strip_edges()
#
	#func find_user_by_identifier(identifier: String) -> Dictionary:
		#var file = FileAccess.open(filename, FileAccess.READ)
		#if not file:
			#print("Error al abrir el archivo de usuarios.")
			#return {}
#
		#while file.get_position() < file.get_length():
			#var initial_position = file.get_position()
			#file.get_buffer(16)  # Saltar el nombre de usuario
#
			## Leer y comparar identificador completo (16 caracteres)
			#if read_partial(file, 16) == identifier:
				#file.seek(initial_position)
				#var user_string = file.get_buffer(36).get_string_from_utf8()
				#file.close()
				#return User.from_string(user_string).to_dict()
#
			#file.seek(initial_position + 36)
#
		#file.close()
		#print("El usuario no existe: ", identifier)
		#return {}
#
	#func find_user_by_name(username: String) -> Dictionary:
		#var file = FileAccess.open(filename, FileAccess.READ)
		#if not file:
			#print("Error al abrir el archivo de usuarios.")
			#return {}
#
		#while file.get_position() < file.get_length():
			#var initial_position = file.get_position()
#
			## Leer y comparar nombre de usuario completo (16 caracteres)
			#if read_partial(file, 16) == username:
				#file.seek(initial_position)
				#var user_string = file.get_buffer(36).get_string_from_utf8()
				#file.close()
				#return User.from_string(user_string).to_dict()
#
			#file.seek(initial_position + 36)
#
		#file.close()
		#print("El usuario no existe: ", username)
		#return {}
#






#
#
#func find_user_by_name(username: String) -> Dictionary:
	#var file = FileAccess.open(filename, FileAccess.READ)
	#if not file:
		#print("Error al abrir el archivo de usuarios.")
		#return {}
#
	#while file.get_position() < file.get_length():
		#var initial_position = file.get_position()
#
			## Leer y comparar nombre de usuario en partes de 4, 8 y 16 caracteres
		#if read_partial(file, 4) != username.substr(0, 4):
			#file.seek(initial_position + 36)
			#continue
		#if read_partial(file, 8) != username.substr(0, 8):
			#file.seek(initial_position + 36)
			#continue
		#if read_partial(file, 16) != username:
			#file.seek(initial_position + 36)
			#continue
#
			## Si coincide, leer el bloque completo
		#file.seek(initial_position)
		#var user_string = file.get_buffer(36).get_string_from_utf8()
		#file.close()
		#return User.from_string(user_string).to_dict()
#
	#file.close()
	#print("El usuario no existe: ", username)
	#return {}

















func prueba():
	var manager = UserArrayManager.new("res://users.dat", "res://history.dat")

	# Intentar agregar usuarios
	manager.save_user("john_doe", "163456789016", "securepass")
	manager.save_user("jane_doe", "987654321098", "anotherpass")
	manager.save_user("john_doe", "163456789016", "securepass")  # Este debería imprimir "El usuario ya existe"

	# Intentar obtener un usuario que no existe
	var non_existent_user = manager.get_user_by_identifier("987654321098")
	if non_existent_user.is_empty():
		print("El usuario no existe: 000000000000")
	else:
		print("El usuario si existe: 987654321098")

	# Intentar obtener un usuario por nombre que no existe
	var non_existent_name = manager.get_user_by_name("john_doe")
	if non_existent_name.is_empty():
		print("El usuario no existe: non_existent_user")
	else:
		print("El usuario si existe: john_doe")
		

	# Mostrar usuarios que están en el array actualmente
	var users = manager.get_users()
	for user in users:
		print("Usuario: ", user["username"], ", Identificador: ", user["identifier"], ", Contraseña: ", user["password"])
#
	## Recuperar un usuario existente por identificador
	#var existing_user = manager.get_user_by_identifier("163456789016")
	#if not existing_user.is_empty():
		#print("Usuario encontrado: ", existing_user["username"], ", Identificador: ", existing_user["identifier"], ", Contraseña: ", existing_user["password"])
#
	## Recuperar un usuario existente por nombre
	#var existing_name = manager.get_user_by_name("john_doe")
	#if not existing_name.is_empty():
		#print("Usuario encontrado: ", existing_name["username"], ", Identificador: ", existing_name["identifier"], ", Contraseña: ", existing_name["password"])
#
	## Recuperar un usuario existente por nombre
	#existing_name = manager.get_user_by_name("john_doe")
	#if not existing_name.is_empty():
		#print("Usuario encontrado: ", existing_name["username"], ", Identificador: ", existing_name["identifier"], ", Contraseña: ", existing_name["password"])
	#existing_name = manager.get_user_by_name("john_doe")
	#if not existing_name.is_empty():
		#print("Usuario encontrado: ", existing_name["username"], ", Identificador: ", existing_name["identifier"], ", Contraseña: ", existing_name["password"])
	#existing_name = manager.get_user_by_name("john_doe")
	#if not existing_name.is_empty():
		#print("Usuario encontrado: ", existing_name["username"], ", Identificador: ", existing_name["identifier"], ", Contraseña: ", existing_name["password"])
	#existing_name = manager.get_user_by_name("john_doe")
	#if not existing_name.is_empty():
		#print("Usuario encontrado: ", existing_name["username"], ", Identificador: ", existing_name["identifier"], ", Contraseña: ", existing_name["password"])
#
#

















func _ready() -> void:
	#prueba()
	
	pass

func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_A):
		prueba_dos()
	if Input.is_key_pressed(KEY_P):
		prueba()
	if Input.is_key_pressed(KEY_M):
		prueba_tres()
		
	if Input.is_key_pressed(KEY_F):
		eliminar_todos_los_usuarios()
		
		
	if Input.is_key_pressed(KEY_N):
		_test_update_user()
		
		pass
			#
			#prueba2(prueba_dos()


# Función auxiliar para rellenar con ceros a la derecha
func pad_right(text: String, length: int) -> String:
	while text.length() < length:
		text += "0"
	return text

# Función de prueba dos
func prueba_dos():
	var manager = UserArrayManager.new("res://users.dat", "res://history.dat")
	var random = RandomNumberGenerator.new()
	random.randomize()

	# Generar 100 usuarios aleatorios
	var loop = 100
	while  loop:
		loop -= 1
		var username = "user_user" + str(random.randi_range(10, 9999))
		var identifier = pad_right(str(random.randi_range(100000000000, 999999999999)), 16)
		var password = "pass_pass" + str(random.randi_range(10, 9999))
		
		manager.save_user(username, identifier, password)

	print("100 usuarios aleatorios creados y guardados.")
	
	
	
	
	
	
	


func prueba_tres():
	var manager = UserArrayManager.new("res://users.dat", "res://history.dat")
	var deleter = UserDeleter.new("res://users.dat")
	var random = RandomNumberGenerator.new()
	random.randomize()

	# Generar 3 usuarios aleatorios
	for i in range(3):
		var username = "user_user" + str(random.randi_range(1000, 9999))
		var identifier = pad_right(str(random.randi_range(100000000000, 999999999999)), 16)
		var password = "pass_pass" + str(random.randi_range(1000, 9999))
		manager.save_user(username, identifier, password)

	print("3 usuarios aleatorios creados y guardados.")

	# Eliminar 2 usuarios aleatorios
	for i in range(2):
		var users = manager.get_users()
		if users.size() > 0:
			var user_to_delete = users[random.randi_range(0, users.size() - 1)]
			deleter.delete_user_by_identifier(user_to_delete["identifier"], user_to_delete["password"])

	print("2 usuarios aleatorios eliminados.")

	# Generar 2 usuarios aleatorios adicionales
	for i in range(2):
		var username = "user_user" + str(random.randi_range(1000, 9999))
		var identifier = pad_right(str(random.randi_range(100000000000, 999999999999)), 16)
		var password = "pass_pass" + str(random.randi_range(1000, 9999))
		manager.save_user(username, identifier, password)

	print("2 usuarios aleatorios adicionales creados y guardados.")


func list_user():
	var timer_local = Time.get_ticks_msec()
	var manager = UserArrayManager.new("res://users.dat", "res://history.dat")

	var limiter = -1
	var users = manager.get_users()
	for user in users:
		limiter += 1
	prints(" total user en cache " , limiter)
	print(" bloques del archivo. (manager.get_users()) en milisegundos (" , Time.get_ticks_msec() - timer_local ,") ")
	
func eliminar_todos_los_usuarios():
	var manager = UserArrayManager.new("res://users.dat", "res://history.dat")
	var deleter = UserDeleter.new("res://users.dat")
	var limiter = 100
	var users = manager.get_users()
	for user in users:
		limiter-= 1 
		prints("user eliminado " , user["username"] , " identificador " , user["identifier"])
		deleter.delete_user_by_identifier(user["identifier"], user["password"])
		if limiter == 0 :
			prints("100 user delete ")
			return 

	print("100 los usuarios han sido eliminados.")




func _test_update_user():
	var manager = UserArrayManager.new("users.dat", "history.dat")
	manager.save_user("john_doe", "1634567890163445", "securepass")
	manager.save_user("jane_doe", "9876543210981634", "anotherpass")
	
	var result = manager.update_user("user16345678", "oldpassword", "newusername", "newpassword")
	if result:
		print("Usuario actualizado correctamente.")
	else:
		print("Error al actualizar el usuario.")
		



	# Actualización fallida porque la contraseña es incorrecta
	result = manager.update_user("john_doe", "wrongpassword", "newusername", "newpassword")
	if result:
		print("Usuario actualizado correctamente.")
	else:
		print("Error al actualizar el usuario.")

	# Actualización exitosa
	result = manager.update_user("john_doe", "securepass", "newusername", "newpassword")
	if result:
		print("Usuario actualizado correctamente.")
	else:
		print("Error al actualizar el usuario.")



		
		
		
	result = manager.update_user("jone_doe", "securepass", "newusername", "newpassword")
	if result:
		print("Usuario actualizado correctamente.")
	else:
		print("Error al actualizar el usuario.")
		
		## atencon anted de actualizar el usuario omprobar si existe el nombre 
		## no existe inplementaacion en la clase 
		
	var existing_name = manager.get_user_by_name("john_doe")
	if not existing_name.is_empty():
		print("Usuario encontrado: ", existing_name["username"], ", Identificador: ", existing_name["identifier"], ", Contraseña: ", existing_name["password"])

	existing_name = manager.get_user_by_name("jane_doe")
	if not existing_name.is_empty():
		print("Usuario encontrado: ", existing_name["username"], ", Identificador: ", existing_name["identifier"], ", Contraseña: ", existing_name["password"])
	#existing_name = manager.get_user_by_name("john_doe")
	#if not existing_name.is_empty():
		#print("Usuario encontrado: ", existing_name["username"], ", Identificador: ", existing_name["identifier"], ", Contraseña: ", existing_name["password"])
	#existing_name = manager.get_user_by_name("john_doe")
	#if not existing_name.is_empty():
		#print("Usuario encontrado: ", existing_name["username"], ", Identificador: ", existing_name["identifier"], ", Contraseña: ", existing_name["password"])
	#existing_name = manager.get_user_by_name("john_doe")
	#if not existing_name.is_empty():
		#print("Usuario encontrado: ", existing_name["username"], ", Identificador: ", existing_name["identifier"], ", Contraseña: ", existing_name["password"])
#

func _on_add_100_user_pressed() -> void:
	prueba_dos()
	pass # Replace with function body.


func _on_deleter_100_user_pressed() -> void:
	eliminar_todos_los_usuarios()
	pass # Replace weliith function body.


func _on_add_quit_random_pressed() -> void:
	prueba_tres()
	pass # Replace with function body.


func _on_user_add_admin_pressed() -> void:
	prueba()
	pass # Replace with function body.


func _on_user_update_pressed() -> void:
	_test_update_user()
	pass # Replace with function body.


func _on_list_user_pressed() -> void:
	list_user()
	pass # Replace with function body.


func _on_salir_pressed() -> void:
	queue_free()
	pass # Replace with function body.


func _on_log_history_pressed() -> void:
	
	var data_exten = load("res://nvr/main/escenas/edit.tscn").instantiate()
	data_exten.current_dir = "res://history.dat"
	

	add_child(data_exten)
	prints("⭐️ DATOS HISTORY INSTANCIADO ⭐️" )

	
	pass # Replace with function body.
