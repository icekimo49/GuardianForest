extends CharacterBody2D

var speed = 1000
var kabur = false
var player = null

func _physics_process(delta):
	if kabur:
		var start_position = position
		var target_position = Vector2(1000, 0)  # Ubah posisi tujuan sesuai kebutuhan Anda
		var direction = (target_position - start_position).normalized()
		position += direction * speed * delta
	
	

func _on_area_2d_body_entered(body):
	player = body
	kabur = true
