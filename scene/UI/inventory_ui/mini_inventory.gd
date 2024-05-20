extends Control

@onready var inv : Inv = preload("res://script/inventory/playerinv.tres")
@onready var slots : Array = $NinePatchRect/GridContainer.get_children()
var use_item = false

func update_slots():
	var j = 8
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[j])
		j+=1

func _ready():
	inv.update.connect(update_slots)
	update_slots()

func _on_touch_screen_button_pressed():
	if GlobalScript.inv_is_open:
		if GlobalScript.select1 == null:
			GlobalScript.select1 = 8
		elif GlobalScript.select2 == null:
			GlobalScript.select2 = 8
	else:
		if use_item == true:
			use_item = false 
			GlobalScript.item_in_use = ""
		else:
			if inv.slots[8].item.type == false:
				use_item = true
				GlobalScript.item_in_use = inv.slots[8].item.name
		print(GlobalScript.item_in_use)

func _on_touch_screen_button_2_pressed():
	if GlobalScript.inv_is_open:
		if GlobalScript.select1 == null:
			GlobalScript.select1 = 9
		elif GlobalScript.select2 == null:
			GlobalScript.select2 = 9
	else:
		if use_item == true:
			use_item = false 
			GlobalScript.item_in_use = ""
		else:
			if inv.slots[9].item.type == false:
				use_item = true
				GlobalScript.item_in_use = inv.slots[9].item.name
		print(GlobalScript.item_in_use)

func _on_touch_screen_button_3_pressed():
	if GlobalScript.inv_is_open:
		if GlobalScript.select1 == null:
			GlobalScript.select1 = 10
		elif GlobalScript.select2 == null:
			GlobalScript.select2 = 10
	else:
		if use_item == true:
			use_item = false 
			GlobalScript.item_in_use = ""
		else:
			if inv.slots[10].item.type == false:
				use_item = true
				GlobalScript.item_in_use = inv.slots[10].item.name
		print(GlobalScript.item_in_use)
