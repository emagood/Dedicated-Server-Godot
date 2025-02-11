'''
No es solo texto plano :)

Se puede comprimir con acssesfile x . no

combertir todo a 16 bit 
16 . 32 . 48
'''

extends Node

class_name  User_tool


class User:
	var username: String
	var identifier: String
	var password: String

	func _init(username: String, identifier: String, password: String):
		self.username = username
		self.identifier = identifier
		self.password = password

	func serialize() -> String:
		return pad_right(username, 16) + pad_right(identifier, 16) + pad_right(password, 16)

	static func from_string(user_string: String) -> User:
		if user_string.length() < 48:
			return null  # Devolver null si los datos del usuario no son válidos

		var username = user_string.substr(0, 16).strip_edges()
		var identifier = user_string.substr(16, 16).strip_edges()
		var password = user_string.substr(32, 16).strip_edges()
		return User.new(username, identifier, password)

	func to_dict() -> Dictionary:
		return {"username": username, "identifier": identifier, "password": password}

	func pad_right(text: String, length: int) -> String:
		while text.length() < length:
			text += " "
		return text

		##clase user para eliminar usuarios

class UserDeleter:
	var filename: String

	func _init(filename: String):
		self.filename = filename

	func read_partial(file, length: int) -> String:
		return file.get_buffer(length).get_string_from_utf8().strip_edges()

	func pad_right(text: String, length: int) -> String:
		while text.length() < length:
			text += " "
		return text

	func delete_user_by_identifier(identifier: String, password: String) -> bool:
		var file = FileAccess.open(filename, FileAccess.READ_WRITE)
		if not file:
			print("Error al abrir el archivo de usuarios.")
			return false

		while file.get_position() < file.get_length():
			var initial_position = file.get_position()
			file.get_buffer(16)  # Saltar el nombre de usuario

			# Leer y comparar identificador y contraseña
			if read_partial(file, 16) == identifier and read_partial(file, 16) == password:
				# Si coincide, borrar el bloque completo
				file.seek(initial_position)
				file.store_buffer(pad_right("", 48).to_utf8_buffer())
				file.close()
				return true

			# Saltar al siguiente bloque de 48
			file.seek(initial_position + 48)

		file.close()
		print("El usuario no existe o la contraseña es incorrecta.")
		return false

	func delete_user_by_name(username: String, password: String) -> bool:
		var file = FileAccess.open(filename, FileAccess.READ_WRITE)
		if not file:
			print("Error al abrir el archivo de usuarios.")
			return false

		while file.get_position() < file.get_length():
			var initial_position = file.get_position()

			# Leer y comparar nombre de usuario (16 caracteres) y contraseña
			if read_partial(file, 16) == username:
				file.seek(initial_position + 16)  # Moverse a la posición de la contraseña
				if read_partial(file, 16) == password:
					# Si coincide, borrar el bloque completo
					file.seek(initial_position)
					file.store_buffer(pad_right("", 48).to_utf8_buffer())
					file.close()
					return true

			## Saltar al siguiente bloque de 48
			file.seek(initial_position + 48)

		file.close()
		print("El usuario no existe o la contraseña es incorrecta.")
		return false




class UserSearcher:
	var filename: String

	func _init(filename: String):
		self.filename = filename

	func read_partial(file: FileAccess, length: int) -> String:
		return file.get_buffer(length).get_string_from_utf8().strip_edges()

	func find_user_by_identifier(identifier: String) -> Dictionary:
		var file = FileAccess.open(filename, FileAccess.READ)
		if not file:
			print("Error al abrir el archivo de usuarios.")
			
			return {}

		while file.get_position() < file.get_length():
			var initial_position = file.get_position()
			file.get_buffer(16)  # Saltar el nombre de usuario

			# Leer y comparar identificador completo (16 caracteres)
			if read_partial(file, 16) == identifier:
				file.seek(initial_position)
				var user_string = file.get_buffer(48).get_string_from_utf8()
				file.close()
				return User.from_string(user_string).to_dict()

			file.seek(initial_position + 48)

		file.close()
		print("El usuario no existe: ", identifier)
		return {}

	func find_user_by_name(username: String) -> Dictionary:
		var file = FileAccess.open(filename, FileAccess.READ)
		if not file:
			print("Error al abrir el archivo de usuarios.")
			return {}

		while file.get_position() < file.get_length():
			var initial_position = file.get_position()

			# Leer y comparar nombre de usuario completo (16 caracteres)
			if read_partial(file, 16) == username:
				file.seek(initial_position)
				var user_string = file.get_buffer(48).get_string_from_utf8()
				file.close()
				return User.from_string(user_string).to_dict()

			file.seek(initial_position + 48)

		file.close()
		print("El usuario no existe: ", username)
		return {}



class ChangeHistory:
	var history: Array = []
	var max_history_size: int
	var filename: String

	func _init(filename: String, max_history_size: int = 100000):
		self.filename = filename
		self.max_history_size = max_history_size
		load_history_from_file()  ## Cargar historial desde el archivo al iniciar

	func add_change(action: String, username: String, identifier: String, timestamp: String):  # Cambiar a String
		var change_record = {
			"action": action,
			"username": username,
			"identifier": identifier,
			"timestamp": timestamp  # No es necesario convertir a String
		}
		history.append(change_record)
		if history.size() > max_history_size:
			## En lugar de eliminar el registro más antiguo, lo escribimos en el archivo y mantenemos todos los datos en el archivo
			save_history_to_file()
		else:
			save_history_to_file()

	func save_history_to_file():
		var file = FileAccess.open(filename, FileAccess.WRITE)
		if not file:
			print("Error al abrir el archivo de historial.")
			return
		for record in history:
			var line = record["timestamp"] + " - " + record["action"] + " - " + record["username"] + " - " + record["identifier"]
			file.store_line(line)
		file.close()

	func load_history_from_file():
		var file = FileAccess.open(filename, FileAccess.READ)
		if not file:
			print("Error al abrir el archivo de historial.")
			return
		while not file.eof_reached():
			var line = file.get_line().strip_edges()
			var parts = line.split(" - ")
			if parts.size() == 4:
				var change_record = {
					"timestamp": parts[0],
					"action": parts[1],
					"username": parts[2],
					"identifier": parts[3]
				}
				history.append(change_record)
		file.close()

	func get_history() -> Array:
		return history

	func get_history_line_by_line() -> String:
		var file = FileAccess.open(filename, FileAccess.READ)
		if not file:
			print("Error al abrir el archivo de historial.")
			return ""
		var lines = []
		while not file.eof_reached():
			var line = file.get_line().strip_edges()
			if line != "":
				lines.append(line)
		file.close()
		return String("\n").join(lines)










class UserArrayManager:
	var cache: Dictionary = {}  ## Usar solo el diccionario para la caché
	var max_cache_size: int = 100000
	var filename: String
	var history_filename: String
	var searcher: UserSearcher
	var history: ChangeHistory

	func _init(filename: String, history_filename: String, max_history_size: int = 100000):
		self.filename = filename
		self.history_filename = history_filename
		self.searcher = UserSearcher.new(filename)
		self.history = ChangeHistory.new(history_filename, max_history_size)
		check_and_create_files()
		load_users_from_file()  # Cargar usuarios desde el archivo al iniciar

	## Método para cambiar el nombre de usuario y/o contraseña si el usuario está verificado
	func update_user(username: String, current_password: String, new_username: String = "", new_password: String = "") -> bool:
		var user = get_user_by_name(username)
		if user.is_empty() or user["password"].strip_edges() != current_password.strip_edges():
			print("Usuario no verificado o contraseña incorrecta.")
			history.add_change("USER_PASSWORD_ERROR", username, "************", String.num(Time.get_unix_time_from_system(),0) )
			return false

		if new_username != "":
			user["username"] = pad_with_spaces(new_username, 16)
		if new_password != "":
			user["password"] = pad_with_spaces(new_password, 16)

		var updated_user = User.new(user["username"], user["identifier"], user["password"])
		var user_string = updated_user.serialize()

	# Actualizar el archivo
		var file = FileAccess.open(filename, FileAccess.READ_WRITE)
		if not file:
			print("Error al abrir el archivo de usuarios.")
			history.add_change("USER_FILE_DIR_ERROR", filename, "************", String.num(Time.get_unix_time_from_system(),0) )
			return false

		while file.get_position() < file.get_length():
			var initial_position = file.get_position()
			var current_block = file.get_buffer(48).get_string_from_utf8()
			var block_user = User.from_string(current_block)

			if block_user and block_user.username.strip_edges() == username.strip_edges():
				file.seek(initial_position)
				file.store_buffer(user_string.to_utf8_buffer())
				file.close()
				cache[user["identifier"]] = updated_user.to_dict()
				print("Usuario actualizado.")
				var tiempo = Time.get_unix_time_from_system()
				history.add_change("UPDATE", updated_user.username, updated_user.identifier, Time.get_datetime_string_from_system() +" "  + String.num(tiempo,-1) )
				prints("usuario actualizado con exito")
				return true

			file.seek(initial_position + 48)

		file.close()
		print("Usuario no encontrado.")
		history.add_change("USER_MISS_ERROR", username, "************", String.num(Time.get_unix_time_from_system(),0) )
		return false

	func pad_with_spaces(text: String, length: int) -> String:
		while text.length() < length:
			text += " "
		return text

	# Comprobar y crear archivos si no existen
	func check_and_create_files():
		if not FileAccess.file_exists(filename):
			var file = FileAccess.open(filename, FileAccess.WRITE)
			if file:
				file.close()

		if not FileAccess.file_exists(history_filename):
			var file = FileAccess.open(history_filename, FileAccess.WRITE)
			if file:
				file.close()

	# Cargar usuarios desde el archivo
	func load_users_from_file():
		var file = FileAccess.open(filename, FileAccess.READ)
		if not file:
			history.add_change("USER_FILE_DAT_ERROR", filename, "************", String.num(Time.get_unix_time_from_system(),0) )
			print("Error al abrir el archivo de usuarios.")
			return
		var count = 0
		while not file.eof_reached():
			count += 1
			var user_string = file.get_buffer(48).get_string_from_utf8()
			var user = User.from_string(user_string)
			if cache.size() < max_cache_size:
				if user:
					cache[user.identifier] = user.to_dict()
		file.close()
		prints("total de users ", count)


	# Recuperar un usuario por su nombre
	# Recuperar un usuario por su nombre
	func get_user_by_name(username: String) -> Dictionary:
		username = pad_with_spaces(username, 16)  # Rellenar con espacios hasta 16 caracteres

	# Buscar en la caché
		for user in cache.values():
			if user["username"].strip_edges() == username.strip_edges():
				return user

	# Buscar en el archivo
		var user_data = searcher.find_user_by_name(username)
		if not user_data.is_empty():
			cache[user_data["identifier"]] = user_data
			if cache.size() > max_cache_size:
				write_cache_to_file_and_clear(10)  # Escribir los datos de la caché al archivo si se supera el tamaño de la caché
		return user_data

	# Recuperar un usuario por su identificador
	func get_user_by_identifier(identifier: String) -> Dictionary:
		if identifier in cache:
			return cache[identifier]

		#// Buscar en el archivo
		var user_data = searcher.find_user_by_identifier(identifier)
		if not user_data.is_empty():
			cache[identifier] = user_data
			if cache.size() > max_cache_size:
				write_cache_to_file_and_clear(10)  # Escribir los datos de la caché al archivo si se supera el tamaño de la caché
		return user_data


	# Obtener la lista completa de usuarios
	func get_users() -> Array:
		return cache.values()

	# Guardar un usuario en el archivo
	func save_user(username: String, identifier: String, password: String):
	# Comprobar que el identifier tenga 16 caracteres
		if identifier.length() != 16:
			history.add_change("ERROR_USER_IDENTIFIER_NOT_16", username, identifier, Time.get_datetime_string_from_system() +" "  + String.num(Time.get_unix_time_from_system(),-1) )
			return

		username = pad_with_spaces(username, 16)  # Rellenar con espacios hasta 16 caracteres
		password = pad_with_spaces(password, 16)  # Rellenar con espacios hasta 16 caracteres

	#@# Buscar en la caché por identificador y nombre de usuario
		for user in cache.values():
			if user["identifier"] == identifier:
				history.add_change("ERROR_USER_IDENTIFIER_CACHE", username, identifier, Time.get_datetime_string_from_system() +" "  + String.num(Time.get_unix_time_from_system(),-1) )
				return
			if user["username"] == username:
				history.add_change("ERROR_USER_USERNAME_CACHE", username, identifier, Time.get_datetime_string_from_system() +" "  + String.num(Time.get_unix_time_from_system(),0) )
				return

	## Buscar en el archivo si no está en la caché
		var existing_user_by_identifier = searcher.find_user_by_identifier(identifier)
		if not existing_user_by_identifier.is_empty():
			history.add_change("ERROR_USER_IDENTIFIER", username, identifier, Time.get_datetime_string_from_system() +" "  + String.num(Time.get_unix_time_from_system(),-1) )
			return

		var existing_user_by_name = searcher.find_user_by_name(username)
		if not existing_user_by_name.is_empty():
			history.add_change("ERROR_USER_USERNAME", username, identifier, Time.get_datetime_string_from_system() +" "  + String.num(Time.get_unix_time_from_system(),0) )
			return

	##Crear el objeto usuario y formatear sus datos a una cadena de 48 caracteres
		var user = User.new(username, identifier, password)
		var user_string = user.serialize()

	# Intentar usar un bloque vacío en el archivo
		var file = FileAccess.open(filename, FileAccess.READ_WRITE)
		if not file:
			history.add_change("ERROR_USER_FILE_OPEN", username, identifier, Time.get_datetime_string_from_system() +" "  + String.num(Time.get_unix_time_from_system(),0) )
			return

		while file.get_position() < file.get_length():
			var initial_position = file.get_position()
			var current_block = file.get_buffer(48).get_string_from_utf8()

		#  ,,,.,.,,.,. Verificar si el bloque actual está vacío
			if current_block.strip_edges() == "":
				file.seek(initial_position)
				file.store_buffer(user_string.to_utf8_buffer())
				file.close()
				cache[identifier] = user.to_dict()
				if cache.size() > max_cache_size:
					write_cache_to_file_and_clear(10)  # Escribir los datos de la caché al archivo si se supera el tamaño de la caché
				history.add_change("ADD", username, identifier, Time.get_datetime_string_from_system() +" "  + String.num(Time.get_unix_time_from_system(),0) )
				return

			file.seek(initial_position + 48)

	#¡'''¡'Si no se encontraron bloques vacíos, agregar al final del archivo
		file.seek_end()  #¡'¡ Ir al final del archivo para agregar el nuevo usuario
		file.store_buffer(user_string.to_utf8_buffer())
		file.close()

	# Agregar a la caché
		cache[identifier] = user.to_dict()
		if cache.size() > max_cache_size:
			write_cache_to_file_and_clear(10)  #'''¡'¡'''¡' Escribir los datos de la caché al archivo si se supera el tamaño de la caché

		history.add_change("ADD", username, identifier, Time.get_datetime_string_from_system() +" "  + String.num(Time.get_unix_time_from_system(),0) )


	func write_cache_to_file_and_clear(max_entries_to_write: int):
		history.add_change("FILE_CAHE_", "CACHE_PASS_SIZE_", str(max_entries_to_write), String.num(Time.get_unix_time_from_system(),0) )
		print("La caché está llena. Escribiendo los datos en el archivo y vaciando la caché.")
		var file = FileAccess.open(filename, FileAccess.READ_WRITE)
		if not file:
			history.add_change("FILE_ERROR_", "CACHE_PASS_SIZE_", str(max_entries_to_write), String.num(Time.get_unix_time_from_system(),0) )
			print("Error al abrir el archivo de usuarios.")
			return

		var entries_written = 0
		var cache_keys = cache.keys()  # Obtener las claves de la caché

		for identifier in cache_keys:
			if entries_written >= max_entries_to_write:
				break

			var user_data = cache[identifier]
			var user = User.new(user_data["username"], identifier, user_data["password"])
			var user_string = user.serialize()

		# Resetear la posición al inicio del archivo para cada usuario
			file.seek(0)
			var found_block = false

			while file.get_position() < file.get_length():
				var initial_position = file.get_position()
				var current_block = file.get_buffer(48).get_string_from_utf8()
				var block_user = User.from_string(current_block)

				if block_user and block_user.identifier == identifier and block_user.username == user.username:
					file.seek(initial_position)
					file.store_buffer(user_string.to_utf8_buffer())
					found_block = true
					entries_written += 1
					break

				if current_block.strip_edges() == "":
					file.seek(initial_position)
					file.store_buffer(user_string.to_utf8_buffer())
					found_block = true
					entries_written += 1
					break

				file.seek(initial_position + 48)

			if not found_block:
				file.seek_end()
				file.store_buffer(user_string.to_utf8_buffer())
				entries_written += 1

		# ¡¡¡¡  Eliminar el dato de la caché después de escribirlo en el archivo ·······
			cache.erase(identifier)

		file.close()
		history.add_change("DONE_CACHE_SAVE_", "", "", String.num(Time.get_unix_time_from_system(),0) )
