extends Control

@onready var animation_player = $AnimationPlayer
@onready var penyiram_loading = $PenyiramAir/PenyiramLoading
@onready var loading_bar = $LoadingBar

var progress = []
var namaScene
var loading_status = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	penyiram_loading.play("new_animation")
	animation_player.play("dissolve")
	namaScene = "res://scene/GameTutorial/game_tutorial.tscn"
	ResourceLoader.load_threaded_request(namaScene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	loading_status = ResourceLoader.load_threaded_get_status(namaScene, progress)
	loading_bar.value = floor((progress[0]*100))
	if loading_status == ResourceLoader.THREAD_LOAD_LOADED:
		var newScene = ResourceLoader.load_threaded_get(namaScene)
		get_tree().change_scene_to_packed(newScene)
