extends player
class_name Event

# Nodo que almacena los eventos
var events = []

# Clase que representa un evento
class GameEvent:
	var event_name: String
	var players: Array = []
	var creation_time: int
	var event_modes: Array = []
	var max_players: int
	var event_date: String
	var duration: int  # Duración en segundos

	func _init(name: String, modes: Array, max_players: int, date: String, duration: int):
		event_name = name
		event_modes = modes
		self.max_players = max_players
		event_date = date
		self.duration = duration
		creation_time = Time.get_unix_time_from_system()

	func add_player(player: Player) -> void:
		if players.size() >= max_players:
			print("No se puede añadir más jugadores al evento " + event_name + ". Límite de jugadores alcanzado.")
		else:
			players.append(player)
			print(player.player_id + " se unió al evento " + event_name)

	func remove_player(player_id: String) -> void:
		for player in players:
			if player.player_id == player_id:
				players.erase(player)
				return

	func get_players() -> Array:
		return players

	func is_active() -> bool:
		return Time.get_unix_time_from_system() - creation_time < duration

# Función para crear un nuevo evento con modos de juego, número máximo de jugadores, fecha y duración
func create_event(event_name: String, modes: Array, max_players: int, date: String, duration: int) -> void:
	var new_event = GameEvent.new(event_name, modes, max_players, date, duration)
	events.append(new_event)
	print("Evento creado: " + event_name + " con modos: " + str(modes) + ", Máximo de jugadores: " + str(max_players) + ", Fecha: " + date + ", Duración: " + str(duration) + " segundos")

# Función para unirse a un evento con límite de jugadores
func join_event(event_name: String, player: Player) -> void:
	for event in events:
		if event.event_name == event_name:
			if event.is_active():
				event.add_player(player)
				print(player.player_id + " se unió al evento: " + event_name)
			else:
				print("El evento " + event_name + " ya no está activo.")
			return
	print("Evento no encontrado: " + event_name)

# Función para ver todos los eventos disponibles
func list_events() -> void:
	if events.size() == 0:
		print("No hay eventos disponibles.")
		return

	print("Eventos disponibles:")
	for event in events:
		var player_info = []
		for player in event.players:
			player_info.append(str(player.player_id) + " (IP: " + player.ip + ", Puerto: " + str(player.port) + ")")
		var status = "Activo" if event.is_active() else "Inactivo"
		print("Evento: " + event.event_name + " - Jugadores: " + str(player_info) + " - Modos: " + str(event.event_modes) + " - Fecha: " + event.event_date + " - Duración: " + str(event.duration) + " segundos - Estado: " + status + " - Creado a las: " + str(event.creation_time))

# Función para eliminar un evento
func remove_event(event_name: String) -> void:
	for event in events:
		if event.event_name == event_name:
			events.erase(event)
			print("Evento eliminado: " + event_name)
			return
	print("Evento no encontrado: " + event_name)

# Ejemplo de uso
func _ready() -> void:
	# Crear algunos eventos y jugadores para el ejemplo
	create_event("Evento 1", ["Modo A"], 4, "2024-12-01", 3600)  # 1 hora de duración
	create_event("Evento 2", ["Modo B"], 4, "2024-12-02", 7200)  # 2 horas de duración
	
	var player1 = Player.new("Jugador1", "192.168.1.1", 1234)
	var player2 = Player.new("Jugador2", "192.168.1.2", 1235)
	var player3 = Player.new("Jugador3", "192.168.1.3", 1236)
	var player4 = Player.new("Jugador4", "192.168.1.4", 1237)
	
	join_event("Evento 1", player1)
	join_event("Evento 1", player2)
	join_event("Evento 2", player3)
	join_event("Evento 2", player4)
	
	# Listar eventos
	list_events()
