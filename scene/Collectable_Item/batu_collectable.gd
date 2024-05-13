extends StaticBody2D

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_area_entered(body):
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		queue_free()
