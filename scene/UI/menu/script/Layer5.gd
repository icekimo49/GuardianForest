extends Sprite2D



func _physics_process(delta):
	position += (get_global_mouse_position()/7 * delta) - position
	position *= -1
