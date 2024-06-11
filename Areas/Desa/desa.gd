extends Node2D

@onready var ui_jam = $jam/DayNightCycleUI
@onready var daynightcycle = $NightCycle
@onready var api = preload("res://scene/penebang/api.tscn")
@onready var paman = $npc/paman
@onready var anim = $timeSkipAnim


#alur_cerita_tutorial_selesai jadiin true kalo cerita pas awal tutorialnya abis dan player mau ke hutan
var alur_cerita_tutorial_selesai = false
var sudah_masuk_story = false
var next_target
var speed = 150
var distance
var ubah_arah = false
var arah
var dialog_paman_inun = false
var dialog1 = false
var dialog2 = false
var lanjut = false
var api_nyala = false
var i = 0
var lalala = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$NightCycle.time_stop= true
	if GlobalScript.sudah_tutorial:
		alur_cerita_tutorial_selesai = true
		GlobalScript.tutorial_desa_1 = true
		GlobalScript.tutorial_hutan = true
	if alur_cerita_tutorial_selesai == false and !GlobalScript.sudah_tutorial and GlobalScript.scene_sebelum_loading != "Hutan" and GlobalScript.tutorial_hutan:
		paman.matiinvisible()
		$jam/DayNightCycleUI.visible = false
	distance = $Player.global_position.distance_to(Vector2(895.0, 228.0))
	if GlobalScript.sudah_tutorial or GlobalScript.tutorial_desa_1:
		pass
	elif !GlobalScript.sudah_tutorial or !GlobalScript.tutorial_desa_1:
		$Player.global_position = Vector2(1428.0, 228.0)
	print($Player.global_position)
	daynightcycle.time_tick.connect(ui_jam.set_daytime)
	GlobalScript.path_screen_terakhir_sebelum_loading= "res://Areas/Desa/desa.tscn"
	GlobalScript.scene_sebelum_loading = get_tree().current_scene.get_name()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !GlobalScript.sudah_tutorial and !GlobalScript.tutorial_desa_1:
		$UI/joystick.no_input = true
		if alur_cerita_tutorial_selesai == false:
			if distance > 2 and ubah_arah == false:
				next_target = Vector2(895.0, 228.0)
				arah = "kiri"
				$Player.gerakan_tutorial(next_target, arah)
			elif ubah_arah == true:
				next_target = Vector2(1428.0, 228.0)
				arah = "kanan"
				alur_cerita_tutorial_selesai = true
				$Player.gerakan_tutorial(next_target, arah)
				#paman ikut bareng inun
			elif distance <= 2 and dialog_paman_inun == false:
				if dialog1 == false:
					paman.dialog_paman_inun_desa_1()
					dialog1 = true
				if lanjut == true and api_nyala == false:
					var apii = api.instantiate()
					apii.global_position = Vector2(1428, 243)
					apii.scale = Vector2(8,8)
					add_child(apii)
					api_nyala = true
					$timer_setelah_api.start()
				$Player.posisi_tutorial("bawah")
			distance = $Player.global_position.distance_to(next_target)
		else:
			$Player.gerakan_tutorial(next_target, arah)
	elif !GlobalScript.sudah_tutorial and GlobalScript.tutorial_desa_1 and !lalala:
		next_target = Vector2(975,206)
		arah = "kiri"
		distance = $Player.global_position.distance_to(next_target)
		if distance > 5:
			$Player.gerakan_tutorial(next_target, arah)
		else:
			lalala = true
			paman.dialog_paman_inun_desa_3()
	if GlobalScript.hour == 1  and GlobalScript.minute == 0 and GlobalScript.sudah_tutorial:
		$Player.save()
		get_tree().change_scene_to_packed(load("res://scene/loading_screen/loading_screen.tscn"))
	pass

func _on_pindah_hutan_body_entered(body):
	if body.is_in_group("player"):
		if alur_cerita_tutorial_selesai or GlobalScript.sudah_tutorial:
			$Player.save()
			get_tree().change_scene_to_packed(load("res://scene/loading_screen/loading_screen.tscn"))

func _on_timer_setelah_api_timeout():
	paman.dialog_paman_inun_desa_2()

func kamera_ke_penjual_makan():
	$"warung mbok yem/kamera_jamu".make_current()
	$timer/timer_dialog_penjual_makan.start()

func _on_timer_dialog_penjual_makan_timeout():
	$Player/Camera2D.make_current()
	paman.dialog_paman_inun_desa_4()

func kamera_ke_toko_peralatan():
	$toko_peralatan/kamera_toko_peralatan.make_current()
	$timer/timer_dialog_toko_peralatan.start()

func _on_timer_dialog_toko_peralatan_timeout():
	$Player/Camera2D.make_current()
	paman.dialog_paman_inun_desa_5()

func _on_time_skip_body_entered(body):
	if body.is_in_group("player") && GlobalScript.hour != 0 :
		Engine.time_scale = 20
		await get_tree().create_timer(3)
		anim.play("time_skip")
	else :
		Engine.time_scale = 1

func set_besok():
	GlobalScript.time = 6
	

func _on_time_skip_body_exited(body):
	if body.is_in_group("player") :
		Engine.time_scale = 1
