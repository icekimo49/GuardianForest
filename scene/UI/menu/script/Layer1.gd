extends Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += (get_global_mouse_position()/4 * delta) - position
	position *= -1
