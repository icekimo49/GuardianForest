extends CharacterBody2D

const maksKecepatan = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var arah = arah_kePlayer()
	velocity = arah * maksKecepatan
	move_and_slide()


func arah_kePlayer():
	var player_nodes = get_tree().get_first_node_in_group("player") as Node2D
	if (player_nodes != null):
		return (player_nodes.global_position - global_position).normalized()
		
	return Vector2.ZERO

