extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Lagu.volume_db = lerp(Lagu.volume_db, -70.0, delta)
