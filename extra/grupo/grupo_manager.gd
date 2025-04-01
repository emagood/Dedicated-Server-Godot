extends Node

class_name GroupManager

# Diccionario para guardar los grupos y sus nodos
var groups: Dictionary = {}
var current_group: String = ""

# Tiempo en segundos para verificar los nodos
var check_interval: float = 1.0

func _ready():
	# Inicialización
	print("GroupManager listo")
	# Iniciar un temporizador para verificar los nodos periódicamente
	var timer = Timer.new()
	timer.wait_time = check_interval
	timer.one_shot = false
	timer.connect("timeout", Callable(self, "_on_check_nodes"))
	add_child(timer)
	timer.start()

# Método para cambiar de grupo
func change_group(group_name: String):
	# Salir del grupo actual si es diferente del nuevo grupo
	if current_group != "" and is_in_any_group(current_group):
		quit_group(current_group)
	
	# Unirse al nuevo grupo
	join_group(group_name)
	
	# Actualizar el grupo actual
	current_group = group_name

# Método para unirse a un grupo
func join_group(group_name: String):
	if not is_in_any_group(group_name):
		add_to_group(group_name)
		if group_name not in groups:
			groups[group_name] = []
		groups[group_name].append(self)
		print("Unido al grupo: %s" % group_name)
	else:
		print("Ya está en el grupo: %s" % group_name)

# Método para salir de un grupo
func quit_group(group_name: String):
	if is_in_any_group(group_name):
		remove_from_group(group_name)
		if group_name in groups and self in groups[group_name]:
			groups[group_name].erase(self)
		print("Salido del grupo: %s" % group_name)
	else:
		print("No está en el grupo: %s" % group_name)

# Método para verificar si el nodo está en un grupo
func is_in_any_group(group_name: String) -> bool:
	return get_groups().has(group_name)

# Método para buscar un grupo por nombre y devolver sus nodos
func get_group_nodes(group_name: String) -> Array:
	return get_tree().get_nodes_in_group(group_name)

# Método para enviar una orden a todos los nodos de un grupo
func send_order_to_group(group_name: String, method_name: String, args: Array = []):
	var nodes = get_group_nodes(group_name)
	for node in nodes:
		if node and node.is_inside_tree():
			if node.has_method(method_name):
				node.callv(method_name, args)
			else:
				print("El nodo %s no tiene el método %s" % [node.name, method_name])
		else:
			print("El nodo %s no está activo" % node.name)

# Método para verificar nodos periódicamente
func _on_check_nodes():
	for group_name in groups.keys():
		for node in groups[group_name]:
			if node == null or not node.is_inside_tree():
				groups[group_name].erase(node)
				print("Eliminado nodo null o inactivo del grupo: %s" % group_name)

# Método para imprimir los grupos actuales
func print_groups():
	print("Grupos actuales: " , self.groups.keys())
