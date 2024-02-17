extends CharacterBody2D

const kecepatan : int = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var arah = get_movement_vector()
	var arahNormalized = arah.normalized()
	velocity = arahNormalized * kecepatan
	move_and_slide()

func get_movement_vector():
	var inputX = Input.get_action_strength("ui_kanan")-Input.get_action_strength("ui_kiri")
	var inputY = Input.get_action_strength("ui_bawah")-Input.get_action_strength("ui_atas")
	return Vector2(inputX, inputY)

