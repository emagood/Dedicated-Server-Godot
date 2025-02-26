extends Node

# Definir una variable global para GroupManager
var group_manager: GroupManager

# Método para manejar eventos de entrada
func _input(event):
	if Input.is_key_pressed(KEY_M):
		group_manager.send_order_to_group("grupo_2", "mi_metodo", ["argumento1", "argumento2"])

func _ready():
	# Inicializar el GroupManager y añadirlo como hijo
	group_manager = GroupManager.new()
	add_child(group_manager)

	# Añadir nodos existentes al grupo
	for nodo in get_tree().get_root().get_children():
		if nodo.is_in_group("grupo_2"):
			group_manager.join_group("grupo_2")

	# Imprimir los grupos actuales
	group_manager.print_groups()
