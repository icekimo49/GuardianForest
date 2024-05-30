extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_pindah_hutan_body_entered(body):
	if body.is_in_group("player"):
		var pindah_area = load("res://Areas/Hutan/Scene/hutan.tscn")
		get_tree().change_scene_to_packed(pindah_area)
