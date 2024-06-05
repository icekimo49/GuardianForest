extends Node2D

@onready var ui_jam = $jam/DayNightCycleUI
@onready var daynightcycle = $NightCycle
@onready
#alur_cerita_tutorial_selesai jadiin true kalo cerita pas awal tutorialnya abis dan player mau ke hutan
var alur_cerita_tutorial_selesai = false
var sudah_masuk_story = false
var next_target
var speed = 150
var distance
var ubah_arah = false
var arah

# Called when the node enters the scene tree for the first time.
func _ready():
	distance = $Player.global_position.distance_to(Vector2(895.0, 228.0))
	if GlobalScript.sudah_tutorial:
		pass
	else:
		$Player.global_position = Vector2(1428.0, 228.0)
	daynightcycle.time_tick.connect(ui_jam.set_daytime)
	GlobalScript.path_screen_terakhir_sebelum_loading= "res://Areas/Desa/desa.tscn"
	GlobalScript.scene_sebelum_loading = get_tree().current_scene.get_name()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalScript.sudah_tutorial == false:
		if $Player.global_position == next_target:
			alur_cerita_tutorial_selesai = true
		if alur_cerita_tutorial_selesai == false:
			if distance > 2 and ubah_arah == false:
				next_target = Vector2(895.0, 228.0)
				arah = "kiri"
			elif distance <=2 :
				next_target = Vector2(1428.0, 228.0)
				arah = "kanan"
				ubah_arah = true
				alur_cerita_tutorial_selesai = true
			distance = $Player.global_position.distance_to(next_target)
			print(distance)
		$Player.gerakan_tutorial(next_target, arah)
	if GlobalScript.hour == 1:
		$Player.save()
		get_tree().change_scene_to_packed(load("res://scene/loading_screen/loading_screen.tscn"))
	pass

func _on_pindah_hutan_body_entered(body):
	if body.is_in_group("player"):
		if alur_cerita_tutorial_selesai:
			$Player.save()
			get_tree().change_scene_to_packed(load("res://scene/loading_screen/loading_screen.tscn"))
