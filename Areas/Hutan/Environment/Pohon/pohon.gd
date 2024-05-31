extends StaticBody2D

var posisi = position
@export var api : PackedScene
var deteksi = false
var kebakar = null
var timer: Timer
var timer2: Timer

func _ready():
	timer = $Timer
	timer2 = $Timer2
	GlobalScript.posisi_pohon.append(self.global_position)
	
func mulai_timer1():
	timer.start()
	
func _on_timer_timeout():
	var instance = api.instantiate()
	instance.position = posisi
	add_child(instance)
	mulai_timer2()

func mulai_timer2():
	timer2.start()

func _on_timer_2_timeout():
	queue_free()

func _on_timer_penebang_kayu_timeout():
	queue_free()
	$timer_PenebangKayu.stop()

func _on_area_2d_area_entered(area):
	if area.name == "area_penebangkayu":
		$timer_PenebangKayu.start()
	if area.name == "api_hitbox":
		if deteksi == false:
			print("menyala abangkuh")
			mulai_timer1()
			deteksi = true

func _on_area_2d_area_exited(area):
	if area.name == "area_penebang_kayu":
		$timer_PenebangKayu.stop()
	if area.name == "api_hitbox":
		timer.stop()
		timer2.stop()

func pohon():
	pass
