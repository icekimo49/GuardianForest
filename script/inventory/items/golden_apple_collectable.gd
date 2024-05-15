extends StaticBody2D

@export var item: InvItem
var player = null

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player = body
		player.collect(item)
		player == null
		queue_free()
