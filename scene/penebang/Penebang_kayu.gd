extends CharacterBody2D




var speed = 1000
var kabur = false
var player = null
var arahRandom = randf()
@onready var timer = $Timer



func _physics_process(delta):
	
	if kabur:
		var start_position = position
		var target_position = Vector2(1000,0 )  # Ubah posisi tujuan sesuai kebutuhan Anda
		var direction = (target_position - start_position).normalized()
		position += direction * speed * delta
	
	
func pembuatRandom() -> float :
	var x = 1000
	if randf() < 0.5:
		x = -1000
	return x


func _on_area_2d_body_entered(body):
	player = body
	kabur = true
	timer.start()
	



func _on_timer_timeout():
	$".".queue_free()
