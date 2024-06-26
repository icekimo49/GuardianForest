extends Node2D

var speed : Vector2 = Vector2(0, 200)
var kamera_gerak = false

func mulai():
	$Camera2D.make_current()
	kamera_gerak = true

func _process(delta):
	if kamera_gerak and $Camera2D.position < Vector2(320, 2046):
		$Camera2D.position += speed * delta
		print($Camera2D.position)

func _on_button_pressed():
	$"../Node2D".visible = true 
	$Camera2D.position = Vector2(320, 180)
	visible = false
	kamera_gerak = false
