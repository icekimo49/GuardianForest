extends Control

func _ready():
	close()

func _process(delta):
	if Input.is_action_just_pressed("i"):
		if GlobalScript.inventory_is_open:
			close()
		else:
			open()

func open():
	visible = true
	GlobalScript.inventory_is_open = true

func close():
	visible = false
	GlobalScript.inventory_is_open = false
