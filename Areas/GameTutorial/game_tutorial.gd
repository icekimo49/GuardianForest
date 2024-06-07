extends Node2D
@onready var api = $api
@onready var kamera_player = $Area1/Player/Camera2D
@onready var kamera_2 = $kamera2
@onready var intro = $introCanvas/intro

var boleh_pindah = false
var sudah_di_api = false
var dialog_di_liat_api = false


signal sudah_di_area2

enum AREA {
	AREA1= 1,
	AREA2 =2
}

@onready var pos_kamera_area1 = {
	"KIRI" : kamera_player.limit_left,
	"KANAN" : kamera_player.limit_right,
	"ATAS" : kamera_player.limit_top,
	"BAWAH" : kamera_player.limit_bottom
}

var current_area = AREA.AREA1

# Called when the node enters the scene tree for the first time.
func _ready():
	intro.play("permulaan")
	intro.queue("analog")
	api.timer.stop()
	$inventory/MiniInventory.visible = false
	$tombol_serang/tombolSerang.visible = false
	GlobalScript.scene_sebelum_loading = get_tree().current_scene.get_name()
	connect("sudah_di_area2",Callable(self,"dialog_sebelum_api"))
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Lagu.volume_db = lerp(Lagu.volume_db, -70.0, delta)
	kamera_2.global_position = kamera_player.global_position
	if api == null:
		intro.stop()
		boleh_pindah = true
	if dialog_di_liat_api:
		dialog_sebelum_api()
	#if current_area == AREA.AREA2:
		#dialog_sebelum_api()
	


func _physics_process(delta):
	posisi_kamera_manager()

func _on_ganti_slide_body_entered(body):
	if body.is_in_group("player"):
		#emit_signal("sudah_di_area2")
		$inventory/MiniInventory.visible = true
		$tombol_serang/tombolSerang.visible = true
		dialog_di_liat_api = true
		if current_area == AREA.AREA1:
			current_area = AREA.AREA2
		else :
			current_area = AREA.AREA1
		
func posisi_kamera_manager():
	if current_area == AREA.AREA2:
		kamera_player.limit_left = lerp(kamera_player.limit_left, 1075, get_process_delta_time())
		kamera_player.limit_right = lerp(kamera_player.limit_right, 2250, get_process_delta_time())
	elif (current_area == AREA.AREA1):
		kamera_player.limit_left = lerp(kamera_player.limit_left, pos_kamera_area1["KIRI"], get_process_delta_time())
		kamera_player.limit_right = lerp(kamera_player.limit_right, pos_kamera_area1["KANAN"], get_process_delta_time())

func _on_pindah_ke_hutan_body_entered(body):
	if body.is_in_group("player"):
		if boleh_pindah:
			get_tree().change_scene_to_packed(load("res://scene/loading_screen/loading_screen.tscn"))

func dialog_sebelum_api():
	var distance = $Area1/Player.global_position.distance_to(Vector2(1305, 214))
	if distance > 5:
		$Area1/Player.gerakan_tutorial(Vector2(1305, 214), "kanan")
	else:
		intro.play("matikan_api")
		$Area1/Player.dialog_player_sendiri("gametutorial")
		dialog_di_liat_api = false
	#if sudah_di_api and dialog == false:
		#$Area1/Player.dialog_player_sendiri("gametutorial")
		#$Area1/UI/joystick.no_input = false
		#dialog = true
		#print(dialog)
	#elif sudah_di_api:
		#$Area1/Player.gerakan_tutorial(Vector2(1265.188, 224.8908), "kanan")
		#$Area1/UI/joystick.no_input = true
	
	
	
func _on_cutscene_api_body_entered(body):
	sudah_di_api = true
	if body.is_in_group("player"):
		emit_signal("sudah_di_area2")
