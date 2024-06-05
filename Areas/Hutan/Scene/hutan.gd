extends Node2D

@onready var ui_jam = $jam/DayNightCycleUI
@onready var daynightcycle = $NightCycle
@onready var info_wave = $InfoWave
@onready var info_wave_color = $inforWaveCanvas/InfoWave
@onready var animasi_wave = $inforWaveCanvas/InfoWave/AnimationPlayer
@onready var musuh_tutorial = preload("res://Character/Musuh/Penebang_kayu/Penebang_kayu.tscn")

var durasi_game
var biar_spawn_musuh_tutorial_cuman_sekali = false

func _ready():
	animasi_wave
	$NavigationRegion2D.bake_navigation_polygon(true)
	daynightcycle.time_tick.connect(ui_jam.set_daytime)
	GlobalScript.scene_sebelum_loading = get_tree().current_scene.get_name()
	GlobalScript.path_screen_terakhir_sebelum_loading= "res://Areas/Hutan/Scene/hutan.tscn"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalScript.hour == 1 and GlobalScript.game_berlangsung == false and GlobalScript.sudah_tutorial:
		var wave = $inforWaveCanvas/InfoWave2
		wave.text = "Wave " + str(GlobalScript.tingkat_wave)
		
		#print("wave ke-", GlobalScript.tingkat_wave, " dimulai!!!!!")
		
		GlobalScript.game_berlangsung = true
		$Timer/masuk_map_ke_mulai_game.start()
	if GlobalScript.sudah_tutorial == false and biar_spawn_musuh_tutorial_cuman_sekali == false:
		print("cihuy")
		GlobalScript.game_berlangsung = true
		var musuh = musuh_tutorial.instantiate()
		musuh.global_position = Vector2(1540.66, -85.41129)
		get_parent().add_child(musuh)
		#kamera ke musuh
		#kamera balik ke player
		#tulisan suruh melawan dia
		biar_spawn_musuh_tutorial_cuman_sekali =  true


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
