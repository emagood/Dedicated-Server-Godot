extends VBoxContainer
var texto = "hola"
var data_exten
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	data_exten = load("res://back-sever/escenas/modo_bin/log.tscn").instantiate()
	data_exten.texto = texto


	add_child(data_exten)
	prints("⭐️ DATOS AL NODO TEXTO INSTANCIADO ⭐️ /n hola" )
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if texto.length() >= 900:
		texto = ""
		data_exten.texto = texto
	data_exten.texto = texto


	
	pass
