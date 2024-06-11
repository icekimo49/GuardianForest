extends Control

#var namaScene : PackedScene = load("res://Areas/GameTutorial/game_tutorial.tscn")

@onready var penyiram_loading = $PenyiramAir/PenyiramLoading
@onready var loading_bar = $LoadingBar
@onready var loading_screen = $"."
@onready var sprite_2d = $CanvasLayer/Sprite2D
@onready var warna_kosong_sprite = $warnaKosong
@onready var warna_normal_sprite = $warnaNormal

var progress = []
var namaScene
var loading_status = 0
var warna_normal = Color(1,1,1,1)
var warna_kosong = Color(1,1,1,1)
# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.visible = false
	$UI/joystick.visible = false
	warna_normal = warna_normal_sprite.modulate
	warna_kosong = warna_kosong_sprite.modulate
	penyiram_loading.play("new_animation")
	namaScene = kemana_kita_le()
	ResourceLoader.load_threaded_request(namaScene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sprite_2d.modulate = lerp(sprite_2d.modulate, warna_kosong, delta)
	loading_status = ResourceLoader.load_threaded_get_status(namaScene, progress)
	loading_bar.value = floor((progress[0]*100))
	if loading_status == ResourceLoader.THREAD_LOAD_LOADED:
		await get_tree().create_timer(2.0).timeout
		var newScene = ResourceLoader.load_threaded_get(namaScene)
		print(newScene)
		get_tree().change_scene_to_packed(newScene)

func kemana_kita_le():
	var awal = GlobalScript.scene_sebelum_loading
	var tujuan
	print(GlobalScript.sudah_tutorial, awal)
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
	print(tujuan)
	return tujuan
