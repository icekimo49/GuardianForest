extends StaticBody2D

var api = preload("res://Areas/Hutan/Environment/Api/api.tscn")
var pohon_gede = preload("res://Areas/Hutan/Environment/Pohon/pohon.tscn")
var deteksi = false
var kebakar = false
var waktu_muncul
var timer1 = Timer.new()
var timer2 = Timer.new()

func _ready():
	waktu_muncul = GlobalScript.time

func _process(delta):
	print(get_parent())
	if GlobalScript.time - waktu_muncul >= 0.1:
		var instance = pohon_gede.instantiate()
		instance.position = global_position
		get_parent().add_child(instance)
		queue_free()

func mulai_timer1():
	timer1.set_wait_time(3.0)
	timer1.connect("timeout", Callable(self, "_on_timer1_timeout"))
	add_child(timer1)
	timer1.one_shot = true
	timer1.start()

func _on_timer1_timeout():
	var instance = api.instantiate()
	instance.position = position
	add_child(instance)
	kebakar = true
	mulai_timer2()

func mulai_timer2():
	timer2.set_wait_time(5.0)
	timer2.connect("timeout", Callable(self, "_on_timer2_timeout"))
	add_child(timer2)
	timer2.one_shot = true
	timer2.start()

func _on_timer2_timeout():
	queue_free()

func _on_pohon_area_entered(area):
	if area.name == "api_hitbox":
		if deteksi == false:
			print("menyala abangkuh")
			mulai_timer1()
			deteksi = true

func _on_pohon_area_exited(area):
	if area.name == "api_hitbox":
		if !kebakar:
			timer1.stop()
			timer2.stop()

func pohon():
	pass