extends VBoxContainer

@export var path = ""
@onready var load_dir = $load




func _ready() -> void:
	if path == "":
		load_dir.popup()
	
	pass




func dir_contents(path):
	
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("⭐️DIRECTORIO ENCONTRADO⭐️ : " + file_name)
			else:
				print("⭐ARCHIVO ENCONTRADO⭐️ : " + file_name)
				print("f⭐️EXTENCION DEL ARCHIVO⭐️: " + file_name.get_extension())
				
				if file_name.get_extension() == "gd" : prints("estencion gd")
				if file_name.get_extension() == "txt" :
					prints("estencion gd")
					#var aux = file_name
					column_add("txt",path + "/" + file_name , file_name)
					prints( "⭐️DIRECTORIO⭐️  ",path + "/" + file_name)
					#data_exten.format = "txt"
					##data_exten.address = ip
					#add_child(data_exten)
					#add_child(data_exten)
					#add_child(data_exten)
					#add_child(data_exten)
					#add_child(data_exten)
					#await get_tree().create_timer(3).timeout

				
				
				
				
			file_name = dir.get_next()
	else:
		print("⭐️ EDITOR FALLO : An error occurred when trying to access the path ⭐️")
		
		
	
	
	
	
func column_add(format, dir , n_name):
	var data_exten = load("res://main/escenas/file.tscn").instantiate()
	data_exten.format = format
	data_exten.file_dir = dir
	data_exten.nname = n_name

	add_child(data_exten)
	prints("⭐️ DATOS AL NODO INSTANCIADO ⭐️" ,format , "  ", dir  , "  " , n_name)

	#data_exten.address = ip
	
	

func _on_load_dir_selected(dir: String) -> void:
	self.path = dir
	dir_contents(path)
	pass # Replace with function body.


func _on_button_pressed() -> void:
	load_dir.popup()
	pass # Replace with function body.
