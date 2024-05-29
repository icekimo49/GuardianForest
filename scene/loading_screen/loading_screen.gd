extends Control

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
	warna_normal = warna_normal_sprite.modulate
	warna_kosong = warna_kosong_sprite.modulate
	penyiram_loading.play("new_animation")
	namaScene = "res://scene/GameTutorial/game_tutorial.tscn"
	ResourceLoader.load_threaded_request(namaScene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(loading_screen.modulate)
	sprite_2d.modulate = lerp(sprite_2d.modulate, warna_kosong, delta)
	loading_status = ResourceLoader.load_threaded_get_status(namaScene, progress)
	loading_bar.value = floor((progress[0]*100))
	if loading_status == ResourceLoader.THREAD_LOAD_LOADED:
		var newScene = ResourceLoader.load_threaded_get(namaScene)
		get_tree().change_scene_to_packed(newScene)
