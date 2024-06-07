extends Node2D

@onready var ui_jam = $jam/DayNightCycleUI
@onready var daynightcycle = $NightCycle
@onready var info_wave = $InfoWave
@onready var info_wave_color = $inforWaveCanvas/InfoWave
@onready var animasi_wave = $inforWaveCanvas/animasiWave
@onready var camera_cs = $cameraCS
@onready var game_camera = $GameCamera
@onready var intro = $introCanvas/intro


var durasi_game
var dialog1 = false
var dialog2 = false
var api_selesai_dilempar = false
var api_muncul = false
var isi_air_sungai = false
var bisa_isi_air = false


func _ready():
	if GlobalScript.sudah_tutorial == false:
		$Player.global_position = Vector2(99, 81)
		$tutorial/paman.global_position = Vector2(70,105)
		$Pohon.boleh_kebakar = false
		tutorial()
	else:
		$tutorial.queue_free()
	animasi_wave
	$NavigationRegion2D.bake_navigation_polygon(true)
	daynightcycle.time_tick.connect(ui_jam.set_daytime)
	GlobalScript.scene_sebelum_loading = get_tree().current_scene.get_name()
	GlobalScript.path_screen_terakhir_sebelum_loading= "res://Areas/Hutan/Scene/hutan.tscn"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	isi_air()
	if api_selesai_dilempar == true:
		ubah_kamera()
		api_selesai_dilempar = false
	if get_node("api_tutorial") == null and api_muncul:
		intro.play("temui_paman")
		var distance = $Player.global_position.distance_to(Vector2(99, 81))
		print(distance)
		if distance > 20:
			#$Player.gerakan_tutorial(Vector2(99, 81), "kiri")
			$Player.nav.target_position = Vector2(99, 81)
			$Player.gerak_path_finding(Vector2(99, 81))
		else:
			api_muncul = false
			$tutorial/paman.dialog_paman_inun_hutan_3()
			GlobalScript.tutorial_desa_1 = true
	if GlobalScript.hour == 1 and GlobalScript.minute == 0 and GlobalScript.game_berlangsung == false and GlobalScript.sudah_tutorial:
		var bersiap = $inforWaveCanvas/CenterContainer/InfoWave2
		var wave = $inforWaveCanvas/CenterContainer/InfoWave3
		animasi_wave.play("bersiap")
		wave.text = "Wave " + str(GlobalScript.tingkat_wave) + " dimulai!"
		animasi_wave.queue("wave_mulai")
		GlobalScript.game_berlangsung = true
		$Timer/masuk_map_ke_mulai_game.start()

func tutorial():
	if dialog1 == false:
		$tutorial/paman.dialog_paman_inun_hutan_1()
		dialog1 = true
	elif dialog2 == true:
		$tutorial/paman.dialog_paman_inun_hutan_2()
		dialog2 = false
		intro.play("padamkan_api")

func ubah_kamera():
	if $tutorial/pelempar_api/camera_musuh == null:
		$GameCamera.make_current()
		dialog2 = true
		tutorial()
	elif $tutorial/pelempar_api/camera_musuh.is_current() == false:
		$tutorial/pelempar_api.global_position = Vector2(1867, -371)
		$tutorial/pelempar_api/camera_musuh.make_current()
		$tutorial/pelempar_api.boleh_gerak = true

func animasi_wave_player():
	pass

func _on_masuk_map_ke_mulai_game_timeout():
	print("mulai game")
	get_level()
	mulai_wave(durasi_game)

func get_level():
	durasi_game = 20.0 * GlobalScript.tingkat_wave

func mulai_wave(durasi_game):
	print(durasi_game)
	$Timer/durasi_wave.set_wait_time(durasi_game)
	$Timer/durasi_wave.one_shot = true
	$Timer/durasi_wave.start()

func _on_durasi_wave_timeout():
	animasi_wave.queue("wave_selesai")
	GlobalScript.game_berlangsung = false
	print(GlobalScript.tingkat_wave)
	$Player.change_wave()
	print(GlobalScript.tingkat_wave)
	print("game selesai")
	
	$Player.change_exp(100)

func _on_pindah_desa_body_entered(body):
	if GlobalScript.game_berlangsung == false:
		if body.is_in_group("player"):
			$Player.save()
			get_tree().change_scene_to_packed(load("res://scene/loading_screen/loading_screen.tscn"))

func _on_area_tanam_body_entered(body):
	if body.has_method("player"):
		if GlobalScript.game_berlangsung:
			GlobalScript.boleh_tanam = true

func _on_area_tanam_body_exited(body):
	if body.has_method("player"):
		GlobalScript.boleh_tanam = false

func balik_desa():
	get_tree().change_scene_to_packed(load("res://scene/loading_screen/loading_screen.tscn"))
	$Player.save()

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		bisa_isi_air = true

func _on_timer_sungai_timeout():
	bisa_isi_air = true

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		$NavigationRegion2D/sungai/timer_sungai.stop()
		bisa_isi_air = false

func isi_air():
	if GlobalScript.item_in_use == "ember":
			if bisa_isi_air:
				GlobalScript.isi_air_gayung +=1
				bisa_isi_air = false
				$NavigationRegion2D/sungai/timer_sungai.start()
