extends Control

@onready var inv : Inv = preload("res://script/inventory/playerinv.tres")
@onready var slots : Array = $NinePatchRect/GridContainer.get_children()

func update_slot():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])
		
func _ready():
	update_slot()
	



func _on_touch_screen_button_pressed():
	print("lalala")
