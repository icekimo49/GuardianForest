@tool
extends Control
@export_file("*.tscn") var level_path : String
@export var world_index : int = 1
@onready var label_level_text = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	label_level_text.text = "Level : " + str(world_index)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.is_editor_hint() :
		label_level_text.text = "Level : " + str(world_index)
