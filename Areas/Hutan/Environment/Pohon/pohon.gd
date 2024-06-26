extends StaticBody2D

var posisi = position
@export var api : PackedScene
var deteksi = false
var kebakar = false
var timer1 = Timer.new()
var timer2 = Timer.new()
var boleh_kebakar = true
var pohon_gaboleh_ilang_kebakar = false

func _ready():
	$"../../".bake_navigation_polygon(true)

func tambah_ke_array():
	var tambah = false
	if !tambah:
		var data_di_arr = GlobalScript.posisi_pohon["pohon"].find(self.global_position)
		if data_di_arr == -1:
			GlobalScript.posisi_pohon["pohon"].append(self.global_position)

func mulai_timer1():
	timer1.set_wait_time(3.0)
	timer1.connect("timeout", Callable(self, "_on_timer1_timeout"))
	add_child(timer1)
	timer1.one_shot = true
	timer1.start()

func _on_timer1_timeout():
	var instance = api.instantiate()
	instance.position = posisi
	add_child(instance)
	instance.timer.stop()
	kebakar = true
	mulai_timer2()

func mulai_timer2():
	timer2.set_wait_time(5.0)
	timer2.connect("timeout", Callable(self, "_on_timer2_timeout"))
	add_child(timer2)
	timer2.one_shot = true
	timer2.start()

func _on_timer2_timeout():
	#queue_free()
	#$"../../".bake_navigation_polygon(true)
	#GlobalScript.posisi_pohon["pohon"].erase(self.global_position)
	pass

func _on_timer_penebang_kayu_timeout():
	queue_free()
	$timer_PenebangKayu.stop()

func _on_area_2d_area_entered(area):
	if area.name == "area_penebangkayu":
		$timer_PenebangKayu.start()
	if area.name == "api_hitbox":
		if boleh_kebakar == true:
			if deteksi == false:
				mulai_timer1()
				deteksi = true

func _on_area_2d_area_exited(area):
	if area.name == "area_penebang_kayu":
		$timer_PenebangKayu.stop()
	if area.name == "api_hitbox":
		if !kebakar:
			timer1.stop()
			timer2.stop()

func pohon():
	pass
