extends Node2D

@onready var kamera_player = $Area1/Player/Camera2D
@onready var kamera_2 = $kamera2

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
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Lagu.volume_db = lerp(Lagu.volume_db, -70.0, delta)
	kamera_2.global_position = kamera_player.global_position

func _physics_process(delta):
	posisi_kamera_manager()
	print(AREA.AREA1)

func _on_ganti_slide_body_entered(body):
	if body.is_in_group("player"):
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
		GlobalScript.sudah_tutorial = true
		get_tree().change_scene_to_packed(load("res://Areas/Hutan/Scene/hutan.tscn"))
