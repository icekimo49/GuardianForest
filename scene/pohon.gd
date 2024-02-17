extends StaticBody2D

var posisi = position
@export var api : PackedScene
var deteksi = false
var kebakar = null
var timer: Timer

func _on_area_2d_body_entered(body):
	if deteksi == false:
		mulai_timer()
		print("2")
		deteksi = true

func _ready():
	timer = $Timer
	
func mulai_timer():
	timer.start()
	
func _on_timer_timeout():
	var instance = api.instantiate()
	instance.position = posisi
	add_child(instance)
	
	


func _on_area_2d_body_exited(body):
	deteksi = false
