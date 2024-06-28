extends Node2D

var speed : Vector2 = Vector2(0, 50)
var kamera_gerak = false

func _ready():
	$CanvasLayer/Button.hide()
func mulai():
	$Camera2D.make_current()
	kamera_gerak = true

func _process(delta):
	if kamera_gerak and $Camera2D.position < Vector2(320, 937):
		$Camera2D.position += speed * delta

func _on_button_pressed():
	$"../Node2D".visible = true 
	$Camera2D.position = Vector2(320, 180)
	visible = false
	kamera_gerak = false
	$CanvasLayer/Button.hide()
