extends Control

@onready var levels : Array = [$levelComponent, $levelComponent2, $levelComponent3,$levelComponent4]
@export var current_world : int  = 0

var move_tween : Tween


# Called when the node enters the scene tree for the first time.
func _ready():
	playerMover()


func _input(event):
	if move_tween && move_tween.is_running():
		return
	if event.is_action_pressed("ui_kiri") && current_world > 0:
		current_world -= 1
		playerMover()

		
	if event.is_action_pressed("ui_kanan") && current_world < levels.size() -1:
		current_world += 1
		playerMover()

	

func playerMover():
	move_tween = get_tree().create_tween()
	move_tween.tween_property(
		$playerIcon, "global_position", 
		Vector2(levels[current_world].global_position.x + 10,levels[current_world].global_position.y + 10),
		0.5
		).set_trans(Tween.TRANS_SINE)

func _on_pilih_pressed():
	if levels[current_world].level_path:
		get_tree().change_scene_to_file(str(levels[current_world].level_path))


func _on_kembali_pressed():
	get_tree().change_scene_to_file("res://scene/UI/menu/MainMenu.tscn")


func _on_level_1_pressed():
	if move_tween && move_tween.is_running():
		return
	current_world = 0
	playerMover()


func _on_level_2_pressed():
	if move_tween && move_tween.is_running():
		return
	current_world = 1
	playerMover()


func _on_level_3_pressed():
	if move_tween && move_tween.is_running():
		return
	current_world = 2
	playerMover()
	

func _on_level_4_pressed():
	if move_tween && move_tween.is_running():
		return
	current_world = 3		
	playerMover()
