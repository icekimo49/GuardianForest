extends Node2D

@onready var ui_jam = $jam/DayNightCycleUI
@onready var daynightcycle = $NightCycle
@onready var info_wave = $InfoWave
@onready var info_wave_color = $inforWaveCanvas/InfoWave
@onready var animasi_wave = $inforWaveCanvas/animasiWave
@onready var camera_cs = $cameraCS
@onready var game_camera = $GameCamera
@onready var intro = $introCanvas/intro
@onready var player = $Ysort/Player

var pohon_besar = preload("res://Areas/Hutan/Environment/Pohon/pohon.tscn")
var pohon_kecil = preload("res://Areas/Hutan/Environment/Pohon/pohon_baru_tanam/pohon_kecil.tscn")
var player_
var spawn_player = preload("res://Character/Player/player.tscn")
var durasi_game
var dialog1 = false
var dialog2 = false
var api_selesai_dilempar = false
var api_muncul = false
var isi_air_sungai = false
var bisa_isi_air = false
var respawn = false
var tambah_data_array_pohon = false


func _ready():
	spawn_pohon()
	$tampilan_respawn/tampilan_respawn2.visible = false
	if GlobalScript.sudah_tutorial == false:
		player.global_position = Vector2(99, 81)
		$tutorial/paman.global_position = Vector2(70,105)
		spawn_pohon_tutorial()
		tutorial()
	else:
		$tutorial.queue_free()
	animasi_wave
	daynightcycle.time_tick.connect(ui_jam.set_daytime)
	GlobalScript.scene_sebelum_loading = get_tree().current_scene.get_name()
	GlobalScript.path_screen_terakhir_sebelum_loading= "res://Areas/Hutan/Scene/hutan.tscn"
	for key in GlobalScript.posisi_pohon.keys():
		var value = GlobalScript.posisi_pohon[key]
		print("Key: %s, Value: %s" % [key, value])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	jika_player_mati()
	isi_air()
	if api_selesai_dilempar == true and !GlobalScript.sudah_tutorial:
		ubah_kamera()
		api_selesai_dilempar = false
	if get_node("api_tutorial") == null and api_muncul and !GlobalScript.sudah_tutorial:
		intro.play("temui_paman")
		var distance = player.global_position.distance_to(Vector2(99, 81))
		print(distance)
		if distance > 20:
			#player.gerakan_tutorial(Vector2(99, 81), "kiri")
			player.nav.target_position = Vector2(99, 81)
			player.gerak_path_finding(Vector2(99, 81))
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
		$Ysort/NavigationRegion2D.bake_navigation_polygon(false)
		$Timer/masuk_map_ke_mulai_game.start()

func tutorial():
	if dialog1 == false:
		$tutorial/paman.dialog_paman_inun_hutan_1()
		dialog1 = true
	elif dialog2 == true:
		$tutorial/paman.dialog_paman_inun_hutan_2()
		dialog2 = false
		intro.play("padamkan_api")

func spawn_pohon_tutorial():
	var spawn_pohon = pohon_besar.instantiate()
	spawn_pohon.global_position = Vector2(1441, -119)
	spawn_pohon.boleh_kebakar = false
	get_node("Ysort/NavigationRegion2D/pohon").add_child(spawn_pohon)

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
	player.change_wave()
	print(GlobalScript.tingkat_wave)
	print("game selesai")
	
	player.change_exp(100)

func _on_pindah_desa_body_entered(body):
	if GlobalScript.game_berlangsung == false and get_node("api_tutorial") == null:
		if body.is_in_group("player"):
			tambah_data_array_pohon = true
			for child in $Ysort/NavigationRegion2D/pohon.get_children():
				await child.tambah_ke_array()
			player.save()
			get_tree().change_scene_to_packed(load("res://scene/loading_screen/loading_screen.tscn"))

func _on_area_tanam_body_entered(body):
	if body.has_method("player"):
		if !GlobalScript.game_berlangsung:
			GlobalScript.boleh_tanam = true

func _on_area_tanam_body_exited(body):
	if body.has_method("player"):
		GlobalScript.boleh_tanam = false

func balik_desa():
	player.save()
	GlobalScript.tutorial_hutan = true
	get_tree().change_scene_to_packed(load("res://scene/loading_screen/loading_screen.tscn"))

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		bisa_isi_air = true

func _on_timer_sungai_timeout():
	bisa_isi_air = true

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		$Ysort/NavigationRegion2D/sungai/timer_sungai.stop()
		bisa_isi_air = false

func isi_air():
	if GlobalScript.item_in_use == "ember":
			if bisa_isi_air:
				GlobalScript.isi_air_gayung +=1
				bisa_isi_air = false
				$Ysort/NavigationRegion2D/sungai/timer_sungai.start()

func jika_player_mati():
	if $Ysort/Player == null:
		$tampilan_respawn/tampilan_respawn2.visible = true
		$tampilan_respawn/tampilan_respawn2.mulai_()
		#get_tree().change_scene_to_packed(load("res://scene/loading_screen/loading_screen.tscn"))

func respawn_di_hutan():
	player_ = spawn_player.instantiate()
	player_.global_position = Vector2(103, 73)
	var time_sementara = GlobalScript.time
	get_node("Ysort").add_child(player_)
	GlobalScript.time = time_sementara
	$tampilan_respawn/tampilan_respawn2.visible = false

func tombol_balik_ke_desa():
	var waktu_1 = 1.832 #jam 7 pagi
	while GlobalScript.time > waktu_1 + 6.283:
		waktu_1 += 6.283
	player_ = spawn_player.instantiate()
	get_node("Ysort").add_child(player_)
	GlobalScript.time = waktu_1
	player_.save()
	get_tree().change_scene_to_packed(load("res://scene/loading_screen/loading_screen.tscn"))

func spawn_pohon():
	for key in GlobalScript.posisi_pohon.keys():
		var positions = GlobalScript.posisi_pohon[key]
		if key == "pohon":
			var i = 0
			while i < positions.size():
				var spawn_pohon = pohon_besar.instantiate()
				spawn_pohon.global_position = positions[i]
				get_node("Ysort/NavigationRegion2D/pohon").add_child(spawn_pohon)
				i+=1
		elif key == "pohon_kecil":
			var i = 0
			while i < positions.size():
				var spawn_pohon = pohon_kecil.instantiate()
				spawn_pohon.global_position = positions[i]
				get_node("Ysort/NavigationRegion2D/pohon").add_child(spawn_pohon)
				i+=1
	$Ysort/NavigationRegion2D.bake_navigation_polygon(false)
