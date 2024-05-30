extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.visible = false
	$UI/joystick.visible = false
	await get_tree().create_timer(1.0).timeout
	if GlobalScript.sudah_tutorial:
		get_tree().change_scene_to_packed(load("res://Areas/Hutan/Scene/hutan.tscn"))
	else:
		get_tree().change_scene_to_packed(load("res://Areas/GameTutorial/Menu_ke_tutorial.tscn"))
