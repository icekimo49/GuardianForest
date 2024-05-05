extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalScript.level_berakhir = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalScript.level_berakhir == true:
		print("Malam sudah berakhir!")
