extends Node2D

@onready var ui_jam = $jam/DayNightCycleUI
@onready var daynightcycle = $NightCycle

# Called when the node enters the scene tree for the first time.
func _ready():
	daynightcycle.time_tick.connect(ui_jam.set_daytime)
	GlobalScript.path_screen_terakhir_sebelum_loading= "res://Areas/Desa/desa.tscn"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalScript.hour == 1:
		$Player.save()
		get_tree().change_scene_to_packed(load("res://Areas/Hutan/Scene/hutan.tscn"))
	pass

func _on_pindah_hutan_body_entered(body):
	if body.is_in_group("player"):
		$Player.save()
		get_tree().change_scene_to_packed(load("res://Areas/Hutan/Scene/hutan.tscn"))
