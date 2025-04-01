extends Control




func _ready() -> void:

	pass 



func _process(delta: float) -> void:
	pass
	


func _input(event: InputEvent) -> void:
	#if Input.is_key_pressed(KEY_W): nueva_red(8888,"127.0.0.1")
	#if Input.is_key_pressed(KEY_S): nueva_host(8888)
	#if Input.is_key_pressed(KEY_M): nueva_msj()
	
	pass




#func nueva_msj():
#
	#prints("servidor")
	#var player = preload("res://escena/mensaje/mensaje.tscn").instantiate()
	#add_child(player)
	#prints("instancio escena")
	#await get_tree().create_timer(3).timeout
	#pass





func _on_texto_plano_pressed() -> void:


	var menu = preload("res://back-sever/escenas/mode_view/user_admin.tscn").instantiate()
	add_child(menu)
	prints("instancio escena")
	await get_tree().create_timer(3).timeout
	pass # Replace with function body.


func _on_binarios_pressed() -> void:
	

	var menu = preload("res://back-sever/escenas/modo_bin/elserver.tscn").instantiate()
	add_child(menu)
	prints("instancio escena")
	await get_tree().create_timer(3).timeout

	pass # Replace with function body.


func _on_salir_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_prueba_de_bit_pressed() -> void:

	var menu = preload("res://lib/bit-w/byte_bit.tscn").instantiate()
	add_child(menu)
	prints("instancio escena")
	await get_tree().create_timer(3).timeout

	pass # Replace with function body.




func _on_prueba_ram_pressed() -> void:
	var menu = preload("res://back-sever/time_data_ram.tscn").instantiate()
	add_child(menu)
	prints("instancio escena")

	pass # Replace with function body.


func _on_rsa_pressed() -> void:
	var menu = preload("res://back-sever/rsas.tscn").instantiate()
	add_child(menu)
	prints("instancio escena")
	await get_tree().create_timer(3).timeout
	pass # Replace with function body.
