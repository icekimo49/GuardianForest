extends Area2D

const maksKecepatan = 100
var Player = null
var kabur = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _physics_process(delta):
	pass

func _on_detection_area_body_entered(body):
	var start_position = position
	var target_position = Vector2(1000, 0)
	var direction = (target_position - start_position).normalized()
	position += direction * maksKecepatan

