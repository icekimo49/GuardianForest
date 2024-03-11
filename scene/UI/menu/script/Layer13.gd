extends Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	position += (get_global_mouse_position()/2 * delta) - position
	position *= -1	
