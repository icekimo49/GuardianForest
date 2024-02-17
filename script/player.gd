extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var move = get_movement_vector()
	var direction = move.normalized()
	

func get_movement_vector():
	var vectorX = Input.get_action_strength("ui_kiri")-Input.get_action_strength("ui_kanan")
	var vectorY = Input.get_action_strength("ui_atas")-Input.get_action_strength("ui_bawah")
	return Vector2(vectorX,vectorY)
