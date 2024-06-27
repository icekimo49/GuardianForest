extends Control

#var namaScene : PackedScene = load("res://Areas/GameTutorial/game_tutorial.tscn")

@onready var penyiram_loading = $tampilan1/PenyiramAir/PenyiramLoading
@onready var loading_bar = $tampilan1/LoadingBar

@onready var loading_screen = $"."
@onready var sprite_2d = $CanvasLayer/Sprite2D
@onready var warna_kosong_sprite = $warnaKosong
@onready var warna_normal_sprite = $warnaNormal
@onready var tampilan1 = $tampilan1
@onready var tampilan2 = $tampilan2
@onready var tampilan3 = $tampilan3
@onready var tampilan4 = $tampilan4


var progress = []
var namaScene
var loading_status = 0
var warna_normal = Color(1,1,1,1)
var warna_kosong = Color(1,1,1,1)
var tampilan
# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.visible = false
	$UI/joystick.visible = false
	tampilan = randi_range(1,4)
	await display()
	warna_kosong = warna_kosong_sprite.modulate
	namaScene = kemana_kita_le()
	ResourceLoader.load_threaded_request(namaScene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sprite_2d.modulate = lerp(sprite_2d.modulate, warna_kosong, delta)
	loading_status = ResourceLoader.load_threaded_get_status(namaScene, progress)
	loading_bar.value = floor((progress[0]*100))
	if loading_status == ResourceLoader.THREAD_LOAD_LOADED:
		await get_tree().create_timer(3.0).timeout
		var newScene = load(namaScene)
		get_tree().change_scene_to_packed(newScene)

func kemana_kita_le():
	var awal = GlobalScript.scene_sebelum_loading
	var tujuan
	if awal == "MainMenu" and GlobalScript.sudah_tutorial == false:
		tujuan = "res://Areas/GameTutorial/game_tutorial.tscn"
	elif awal == "MainMenu" and GlobalScript.sudah_tutorial == true:
		tujuan = "res://Areas/Desa/desa.tscn"
	elif awal == "GameTutorial":
		tujuan = "res://Areas/Desa/desa.tscn"
	elif awal == "Desa":
		tujuan = "res://Areas/Hutan/Scene/hutan.tscn"
	elif awal == "Hutan":
		tujuan = "res://Areas/Desa/desa.tscn"
	return tujuan

func display():
	if tampilan == 1:
		tampilan1.visible = true
		tampilan2.visible = false
		tampilan3.visible = false
		tampilan4.visible = false
		penyiram_loading.play("new_animation")
	elif tampilan == 2:
		tampilan1.visible = false
		tampilan2.visible = true
		tampilan3.visible = false
		tampilan4.visible = false
	elif tampilan == 3:
		tampilan1.visible = false
		tampilan2.visible = false
		tampilan3.visible = true
		tampilan4.visible = false
	elif tampilan == 4:
		tampilan1.visible = false
		tampilan2.visible = false
		tampilan3.visible = false
		tampilan4.visible = true
