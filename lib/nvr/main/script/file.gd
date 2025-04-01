extends TextureRect

@export var textur : Texture = self.texture
@export var format : String = ""
@export var file_dir : String = ""
@onready var ntext = $Label
@onready var ndir = $dir_label
@export var nname : String = ""
# Called when the node enters the scene tree for the first time.


	


func _ready() -> void:
	ntext.text = format
	ndir.text = nname
	self.texture = textur
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	##ntext.text = format
	#prints(nname)
	TxtLoad.txt = file_dir
	pass # Replace with function body.
