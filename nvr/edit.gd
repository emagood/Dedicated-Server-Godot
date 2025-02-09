extends Control
@onready var dialogo_save = $CanvasLayer/save
@onready var dialogo_load = $CanvasLayer/load
@onready var ntext_edit = $CanvasLayer/HBoxContainer/TextEdit
@export var current_dir = "res://history.dat"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	prints("⭐️+ EDITOR DE TEXTO EN GODOT + 🎁" , "⭐️ EDITOR READY ⭐️ ")
	if current_dir !=  "":
		load_file(current_dir)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if TxtLoad.txt != current_dir:
		load_file(TxtLoad.txt)
		TxtLoad.txt = current_dir
		prints("⭐️ CARGO EL PATH ⭐️ " , current_dir)
		pass
	
	pass



func _on_boton_save_pressed() -> void:
	dialogo_save.popup()
	pass # Replace with function body.


func _on_boton_load_pressed() -> void:
	dialogo_load.popup()
	pass # Replace with function body.


func _on_load_file_selected(path: String) -> void:
	# Abrir y leer el archivo
	load_file(path)
	
	pass # Replace with function body.


func _on_save_file_selected(path: String) -> void:
	var temp_file = FileAccess.open(path, FileAccess.WRITE)
	if temp_file:
		temp_file.store_string(ntext_edit.text)
		temp_file.close()

	pass # Replace with function body.
	
func load_file(path):
	current_dir = path
	# Abrir y leer el archivo
	
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		var script_content = file.get_as_text()
		ntext_edit.text = script_content
		file.close()

	pass


func _on_salir_pressed() -> void:
	self.queue_free()
	
	pass # Replace with function body.
