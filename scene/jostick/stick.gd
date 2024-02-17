extends Control

var start_pos: Vector2 = Vector2.ZERO

var end_pos: Vector2 = Vector2.ZERO

var valid_pos = false

@onready var js_pos = get_node("background").rect_position

@onready var js_bg = get_node("background")

@onready var js_handle = get_node("background/handle")

func _input(event : InputEvent):
	if (event  is InputEventScreenDrag):
		if (start_pos = event.position):
			pass

func _on_texture_button_button_down():
	valid_pos = true
