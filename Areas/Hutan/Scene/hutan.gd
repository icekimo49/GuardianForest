extends Node2D

@onready var ui_jam = $jam/DayNightCycleUI
@onready var daynightcycle = $NightCycle

var durasi_game

func _ready():
	$NavigationRegion2D.bake_navigation_polygon(true)
	print(GlobalScript.posisi_pohon)
	daynightcycle.time_tick.connect(ui_jam.set_daytime)
	GlobalScript.path_screen_terakhir_sebelum_loading= "res://Areas/Hutan/Scene/hutan.tscn"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalScript.hour == 1 and GlobalScript.game_berlangsung == false:
		print("wave ke-", GlobalScript.tingkat_wave, " dimulai!!!!!")
		GlobalScript.game_berlangsung = true
		$Timer/masuk_map_ke_mulai_game.start()
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
			get_tree().change_scene_to_packed(load("res://Areas/Desa/desa.tscn"))
