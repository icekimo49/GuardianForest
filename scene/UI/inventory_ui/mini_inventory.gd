extends Control

@onready var inv : Inv = preload("res://script/inventory/player_mini_inv.tres")
@onready var slots : Array = $NinePatchRect.get_children()

func update_slot():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])
		
func _ready():
	update_slot()
