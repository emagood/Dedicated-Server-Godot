extends Node
#
#
## Array para guardar los grupos
#var groups: Array = []
#var current_group: String = ""
#
#func _ready():
	## Inicialización
	#print("GroupManager listo")
#
## Método para cambiar de grupo
#func change_group(group_name: String):
	## Salir del grupo actual si es diferente del nuevo grupo
	#if current_group != "" and is_in_any_group(current_group):
		#quit_group(current_group)
	#
	## Unirse al nuevo grupo
	#join_group(group_name)
	#
	## Actualizar el grupo actual
	#current_group = group_name
#
## Método para unirse a un grupo
#func join_group(group_name: String):
	#if not is_in_any_group(group_name):
		#add_to_group(group_name)
		#if group_name not in groups:
			#groups.append(group_name)
		#print("Unido al grupo: %s" % group_name)
	#else:
		#print("Ya está en el grupo: %s" % group_name)
#
## Método para salir de un grupo
#func quit_group(group_name: String):
	#if is_in_any_group(group_name):
		#remove_from_group(group_name)
		#print("Salido del grupo: %s" % group_name)
	#else:
		#print("No está en el grupo: %s" % group_name)
#
## Método para verificar si el nodo está en un grupo
#func is_in_any_group(group_name: String) -> bool:
	#return get_groups().has(group_name)
#
## Método para imprimir los grupos actuales
#func print_groups():
	#print("Grupos actuales: %s" % str(groups))
