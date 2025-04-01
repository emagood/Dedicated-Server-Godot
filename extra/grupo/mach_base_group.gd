extends Node

# Definir una variable global para GroupManager
var group_manager: GroupManager

# Método para manejar eventos de entrada
func _input(event):
	if Input.is_key_pressed(KEY_M):
		group_manager.send_order_to_group("grupo_2", "mi_metodo", ["argumento1", "argumento2"])
	
	if Input.is_key_pressed(KEY_P):
		group_manager.print_groups()
		prints(group_manager.get_group_nodes("grupo_2"))
		var namr_arr = group_manager.get_group_nodes("grupo_2")
		
		for i in namr_arr.size():
			prints(namr_arr[i].name)
		

func _ready():
	# Inicializar el GroupManager y añadirlo como hijo
	group_manager = GroupManager.new()
	add_child(group_manager)
#
	## Añadir nodos existentes al grupo
	for nodo in self.get_children():
		prints(nodo)
		if !nodo.is_in_group("grupo_2"):
			group_manager.join_group("grupo_2")
		else:
			prints("el nodo : " , nodo.name , " ya esta en el grupo ")
		
	#if !self.is_in_group("grupo_2"):
		#group_manager.join_group("grupo_2")
	#else:
		#prints("ya estas en el grupo desde el nodo ")

	# Imprimir los grupos actuales
	group_manager.print_groups()
