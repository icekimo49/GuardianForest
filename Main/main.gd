extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(GlobalScript.tingkat_wave)

func _on_timer_level_timeout():
	print("waktu habis")
