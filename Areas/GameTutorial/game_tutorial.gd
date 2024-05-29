extends Node2D

@onready var kamera_player = $Area1/Player/Camera2D
@onready var kamera_2 = $kamera2


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Lagu.volume_db = lerp(Lagu.volume_db, -70.0, delta)
	kamera_2.global_position = kamera_player.global_position
	

