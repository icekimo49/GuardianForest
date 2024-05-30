extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalScript.hour == 1:
		$Player.save()
		get_tree().change_scene_to_packed(load("res://Areas/Hutan/Scene/hutan.tscn"))
	pass

func _on_pindah_hutan_body_entered(body):
	if body.is_in_group("player"):
		var pindah_area = load("res://Areas/Hutan/Scene/hutan.tscn")
		get_tree().change_scene_to_packed(pindah_area)
