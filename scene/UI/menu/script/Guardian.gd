extends AnimationPlayer



func _physics_process(delta):
	position += (get_global_mouse_position()* delta) - position
