extends room
# Lista global de jugadores sin sala
# Lista global de jugadores sin sala
var players_without_room = []

# Función para emparejar jugadores según el modo de juego y la disponibilidad
func match_players(rooms: Array) -> void:
	var matched_players = []
	players_without_room.clear()  # Limpiar la lista de jugadores sin sala
	
	# Emparejar jugadores en salas
	for room in rooms:
		for player in room.players:
			var is_matched = false
			for match in matched_players:
				if player in match:
					is_matched = true
					break
			
			if not is_matched:
				for other_player in room.players:
					if player != other_player and other_player not in matched_players:
						matched_players.append([player, other_player])
						print("Emparejados en sala: " + player.player_id + " con " + other_player.player_id)
						break
	
	# Detectar jugadores sin sala
	for room in rooms:
		for player in room.players:
			if player not in matched_players:
				players_without_room.append(player)
	
	# Emparejar jugadores sin sala
	while players_without_room.size() > 1:
		var player1 = players_without_room.pop_front()
		var player2 = players_without_room.pop_front()
		matched_players.append([player1, player2])
		print("Emparejados sin sala: " + player1.player_id + " con " + player2.player_id)
	
	# Emparejar jugadores sin sala restantes
	if players_without_room.size() == 1:
		print("Jugador sin emparejar: " + players_without_room[0].player_id)
	
	# Imprimir los emparejamientos
	if matched_players.size() == 0:
		print("No se encontraron jugadores para emparejar.")
	else:
		print("Emparejamientos realizados:")
		for match in matched_players:
			print(match[0].player_id + " con " + match[1].player_id)

# Ejemplo de uso
func _ready() -> void:
	# Crear algunas salas y jugadores para el ejemplo
	create_room("Sala 1", ["Modo A"], "192.168.1.1", 1234, 4)
	create_room("Sala 2", ["Modo B"], "192.168.1.2", 1235, 4)
	
	var player1 = Player.new("Jugador1", "192.168.1.1", 1234)
	var player2 = Player.new("Jugador2", "192.168.1.2", 1235)
	var player3 = Player.new("Jugador3", "192.168.1.3", 1236)
	var player4 = Player.new("Jugador4", "192.168.1.4", 1237)
	var player5 = Player.new("Jugador5", "192.168.1.5", 1238)
	var player6 = Player.new("Jugador6", "192.168.1.6", 1239)
	match_players(rooms)
	join_room("Sala 1", player1)
	join_room("Sala 2", player2)
	join_room("Sala 2", player3)
	join_room("Sala 2", player4)
	
	# Añadir jugadores sin sala
	#players_without_room.append(player5)
	#players_without_room.append(player6)
	
	# Llamar a la función de emparejamiento
	match_players(rooms)
