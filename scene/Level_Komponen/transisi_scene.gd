extends CanvasLayer

@onready var animation = $AnimationPlayer

func ganti_scene(target: String):
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file(target)
