extends Control

# Nodo que almacena las salas
var rooms = []

# Clase que representa un jugador
class Player:
	var player_id: String
	var ip: String
	var port: int

	func _init(id: String, ip: String, port: int):
		player_id = id
		self.ip = ip
		self.port = port

# Clase que representa una sala




# Clase que representa una sala
# Clase que representa una sala
class Room:
	var room_name: String
	var players: Array = []
	var banned_players: Array = []
	var creation_time: int
	var game_modes: Array = []
	var ip: String
	var port: int
	var max_players: int

	func _init(name: String, modes: Array, ip: String, port: int, max_players: int):
		room_name = name
		game_modes = modes
		self.ip = ip
		self.port = port
		self.max_players = max_players
		creation_time = Time.get_unix_time_from_system()

	func add_player(player: Player) -> void:
		if player.player_id in banned_players:
			print(player.player_id + " está baneado y no puede unirse a la sala " + room_name)
		elif players.size() >= max_players:
			print("No se puede añadir más jugadores a la sala " + room_name + ". Límite de jugadores alcanzado.")
		else:
			players.append(player)
			print(player.player_id + " se unió a la sala " + room_name)

	func remove_player(player_id: String) -> void:
		for player in players:
			if player.player_id == player_id:
				players.erase(player)
				return

	func get_players() -> Array:
		return players

## Función para unirse a una sala con verificación de ban y límite de jugadores
#func join_room(room_name: String, player: Player) -> void:
	#for room in rooms:
		#if room.room_name == room_name:
			#room.add_player(player)
			#return
	#print("Sala no encontrada: " + room_name)












# Función para banear un jugador por nombre en una sala
# Función para banear un jugador por nombre en una sala específica
func ban_player_from_room_by_name(rooms: Array, room_name: String, player_id: String) -> void:
	for room in rooms:
		if room.room_name == room_name:
			for player in room.players:
				if player.player_id == player_id:
					room.players.erase(player)
					room.banned_players.append(player_id)
					print("Jugador " + player_id + " ha sido baneado de la sala " + room.room_name)
					return
			print("Jugador " + player_id + " no encontrado en la sala " + room.room_name)
			return
	print("Sala " + room_name + " no encontrada.")


# Función para crear una nueva sala con modos de juego, IP, puerto y número máximo de jugadores
func create_room(room_name: String, modes: Array, ip: String, port: int, max_players: int) -> void:
	var new_room = Room.new(room_name, modes, ip, port, max_players)
	rooms.append(new_room)
	print("Sala creada: " + room_name + " con modos: " + str(modes) + ", IP: " + ip + ", Puerto: " + str(port) + ", Máximo de jugadores: " + str(max_players))



# Función para unirse a una sala con verificación de ban
func join_room(room_name: String, player: Player) -> void:
	for room in rooms:
		if room.room_name == room_name:
			if player.player_id in room.banned_players:
				print(player.player_id + " está baneado y no puede unirse a la sala: " + room_name)
			else:
				room.add_player(player)
				print(player.player_id + " se unió a la sala: " + room_name)
			return
	print("Sala no encontrada: " + room_name)


# Función para ver todas las salas disponibles
# Función para ver todas las salas disponibles
func list_rooms() -> void:
	if rooms.size() == 0:
		print("No hay salas disponibles.")
		return

	print("Salas disponibles:")
	for room in rooms:
		var player_info = []
		for player in room.players:
			player_info.append(str(player.player_id) + " (IP: " + player.ip + ", Puerto: " + str(player.port) + ")")
		print("Sala: " + room.room_name + " - IP: " + room.ip + ", Puerto: " + str(room.port) + " - Jugadores: " + str(player_info) + " - Modos: " + str(room.game_modes) + " - Creada a las: " + str(room.creation_time))

# Función para comparar dos salas por modo de juego (primero en la lista)
func compare_rooms_by_mode(a: Room, b: Room) -> int:
	if a.game_modes[0] < b.game_modes[0]:
		return -1
	elif a.game_modes[0] > b.game_modes[0]:
		return 1
	else:
		return 0

# Función para ordenar las salas por modo de juego
func sort_rooms_by_mode(rooms: Array) -> void:
	rooms.sort_custom(compare_rooms_by_mode)

# Función para buscar un modo de juego específico en todas las salas
func find_rooms_with_mode(rooms: Array, mode_name: String) -> Array:
	var matching_rooms = []
	for room in rooms:
		if mode_name in room.game_modes:
			matching_rooms.append(room)
	return matching_rooms
	
	
# Función para eliminar una sala
func remove_room(room_name: String) -> void:
	for room in rooms:
		if room.room_name == room_name:
			rooms.erase(room)
			print("Sala eliminada: " + room_name + " con IP: " + room.ip + " y puerto: " + str(room.port))
			return
	print("Sala no encontrada: " + room_name)


# Función para listar un máximo de 10 salas según el modo de juego
func list_top_10_rooms_by_mode(rooms: Array, mode_name: String) -> void:
	var matching_rooms = []
	
	# Encontrar salas que contienen el modo de juego
	for room in rooms:
		if mode_name in room.game_modes:
			matching_rooms.append(room)
			
	# Ordenar las salas por el tiempo de creación
	matching_rooms.sort_custom(compare_rooms_by_mode)
	
	# Limitar el número de salas a 10
	var top_10_rooms = matching_rooms.slice(0, 10)
	
	# Imprimir las salas
	print("Top 10 salas con el modo de juego " + mode_name + ":")
	for room in top_10_rooms:
		var player_info = []
		for player in room.players:
			player_info.append(str(player.player_id) + " (IP: " + player.ip + ", Puerto: " + str(player.port) + ")")
		print("Sala: " + room.room_name + " - IP: " + room.ip + ", Puerto: " + str(room.port) + " - Jugadores: " + str(player_info) + " - Modos: " + str(room.game_modes) + " - Creada a las: " + str(room.creation_time))

## Función para comparar dos salas por modo de juego (primero en la lista)
#func compare_rooms_by_mode(a: Room, b: Room) -> int:
	#if a.game_modes[0] < b.game_modes[0]:
		#return -1
	#elif a.game_modes[0] > b.game_modes[0]:
		#return 1
	#else:
		#return 0

# Ejemplo de uso

# Función para enviar un mensaje de un jugador a otro, especificando la sala por su nombre
func send_message_in_room(rooms: Array, room_name: String, sender: Player, receiver: Player, message: String) -> void:
	for room in rooms:
		if room.room_name == room_name:
			if sender in room.players and receiver in room.players:
				print("Mensaje de " + sender.player_id + " a " + receiver.player_id + " en la sala " + room.room_name + ": " + message)
			else:
				print("Ambos jugadores deben estar en la sala " + room_name + " para enviar mensajes.")
			return
	print("Sala " + room_name + " no encontrada.")


func send_message_to_room(rooms: Array, room_name: String, sender: Player, message: String) -> void:
	for room in rooms:
		if room.room_name == room_name:
			if sender in room.players:
				print("Mensaje de " + sender.player_id + " a todos en la sala " + room.room_name + ": " + message)
				for player in room.players:
					if player != sender:
						print("Mensaje para " + player.player_id + ": " + message)
			else:
				print(sender.player_id + " no está en la sala " + room_name + " y no puede enviar mensajes.")
			return
	print("Sala " + room_name + " no encontrada.")





func _ready() -> void:

	create_room("Sala 1", ["Modo A", "Modo B"], "192.168.1.1", 1234,5)
	create_room("Sala 2", ["Modo B", "Modo C"], "192.168.1.2", 1235,5)
	create_room("Sala 3", ["Modo C", "Modo D"], "192.168.1.3", 1236,2)
	
	print("Antes de eliminar:")
	list_rooms()
	remove_room("Sala 2")
	print("Después de eliminar:")
	list_rooms()


	var player1 = Player.new("Jugador1", "192.168.1.1", 1234)
	var player2 = Player.new("Jugador2", "192.168.1.2", 1235)
	var player3 = Player.new("Jugador3", "192.168.1.3", 1236)

	join_room("Sala 1", player1)
	join_room("Sala 2", player2)
	join_room("Sala 3", player3)
	
	print("Antes de ordenar:")
	list_rooms()
	sort_rooms_by_mode(rooms)
	print("Después de ordenar:")
	list_rooms()
	remove_room("Sala 1")
	list_rooms()
	create_room("Sala 1", ["Modo A", "Modo B"], "192.168.1.1", 1234,4)
	create_room("Sala 2", ["Modo B", "Modo C"], "192.168.1.2", 1235,4)
	create_room("Sala 3", ["Modo C", "Modo D"], "192.168.1.3", 1236,7)
	create_room("Sala 4", ["Modo A", "Modo C"], "192.168.1.4", 1237,2)
	create_room("Sala 5", ["Modo B", "Modo D"], "192.168.1.5", 1238,2)
	create_room("Sala 6", ["Modo A", "Modo D"], "192.168.1.6", 1239,2)
	create_room("Sala 7", ["Modo B", "Modo A"], "192.168.1.7", 1240,2)
	create_room("Sala 8", ["Modo C", "Modo B"], "192.168.1.8", 1241,2)
	create_room("Sala 9", ["Modo A", "Modo B"], "192.168.1.9", 1242,2)
	create_room("Sala 10", ["Modo B", "Modo C"], "192.168.1.10", 1243,2)
	create_room("Sala 11", ["Modo D", "Modo A"], "192.168.1.11", 1244,2)
	create_room("Sala 12", ["Modo A", "Modo B"], "192.168.1.12", 1245,2)
	


	join_room("Sala 1", player1)
	join_room("Sala 2", player2)
	join_room("Sala 3", player3)

	print("Lista de salas antes de filtrar:")
	list_rooms()
	
	list_top_10_rooms_by_mode(rooms, "Modo A")
	join_room("Sala 1", player1)
	join_room("Sala 1", player2)
	join_room("Sala 2", player3)
	send_message_in_room(rooms, "Sala 1", player1, player2, "¡Hola, Jugador2!")
	send_message_in_room(rooms, "Sala 1", player1, player3, "¡Hola, Jugador3!")
	send_message_in_room(rooms, "Sala 2", player1, player3, "¡Hola, Jugador3!")
	
	
	

	# Crear una sala
	create_room("Sala 1", ["Modo A", "Modo B"], "192.168.1.1", 1234,3)
	

	
	# Unir jugadores a la sala
	join_room("Sala 1", player1)
	join_room("Sala 1", player2)
	
	# Banear un jugador de la sala
	var room = rooms[0]
	ban_player_from_room_by_name(rooms,"Sala 1", "Jugador1")
	prints("jugado jugador            ##########################################################################################")
	# Intentar volver a unir el jugador baneado a la sala
	join_room("Sala 1", player1)
	prints("jugado jugador            ##########################################################################################")
	# Listar jugadores en la sala después del baneo
	list_rooms()
	
	send_message_in_room(rooms, "Sala 1", player1, player2, "¡Hola, Jugador2!")
	send_message_in_room(rooms, "Sala 1", player1, player3, "¡Hola, Jugador3!")
	send_message_in_room(rooms, "Sala 2", player1, player3, "¡Hola, Jugador3!")
	send_message_to_room(rooms, "Sala 1", player1, "Hola a todos en Sala 1!")
	
	
