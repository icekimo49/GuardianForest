extends StaticBody2D

var posisi = position
@export var api : PackedScene
var deteksi = false
var kebakar = null
var timer: Timer
var timer2: Timer

func _on_area_2d_body_entered(body):
	if deteksi == false:
		mulai_timer1()
		deteksi = true

func _ready():
	timer = $Timer
	timer2 = $Timer2
	
func mulai_timer1():
	timer.start()
	
func _on_timer_timeout():
	var instance = api.instantiate()
	instance.position = posisi
	add_child(instance)
	mulai_timer2()

func mulai_timer2():
	timer2.start()

func _on_area_2d_body_exited(body):
	pass

func _on_timer_2_timeout():
	queue_free()
