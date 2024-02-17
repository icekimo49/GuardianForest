extends StaticBody2D

var posisi = position
@export var api : PackedScene
var deteksi = false
var kebakar = null
var timer: Timer
var timer2: Timer
var timer3: Timer

func _on_area_2d_body_entered(body):
	if deteksi == false:
		mulai_timer1()
		deteksi = true

func _ready():
	timer = $Timer
	timer2 = $Timer2
	timer3 = $Timer3
	
func mulai_timer1():
	timer.start()
	
func _on_timer_timeout():
	var instance = api.instantiate()
	instance.position = posisi
	add_child(instance)
	mulai_timer2()

func mulai_timer2():
	timer2.start()

func mulai_timer3():
	timer3.start()

func _on_area_2d_body_exited(body):
	timer2.stop()

func _on_timer_2_timeout():
	queue_free()
	
func _on_area_2d_2_body_entered(body):
	mulai_timer3()

func _on_timer_3_timeout():
	queue_free()

func _on_area_2d_2_body_exited(body):
	timer3.stop()
