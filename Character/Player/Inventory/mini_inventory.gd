extends Control

@onready var slots : Array = $NinePatchRect/GridContainer.get_children()
@onready var tombol1 = $NinePatchRect/GridContainer/Inventory_UI_Slot
@onready var tombol2 = $NinePatchRect/GridContainer/Inventory_UI_Slot2
@onready var tombol3 = $NinePatchRect/GridContainer/Inventory_UI_Slot3
@onready var drag_item = $Sprite2D


var warna_awal
var use_item = false
var drag : bool
var lok_pencet

func update_slots():
	var j = 8
	for i in range(min(GlobalScript.inv.slots.size(), slots.size())):
		slots[i].update(GlobalScript.inv.slots[j])
		j+=1

func get_texture(number):
	if GlobalScript.inv.slots[number].item:
		if !drag_item.texture:
			drag_item.texture = GlobalScript.inv.slots[number].item.texture
			drag_item.scale = GlobalScript.inv.slots[number].item.ukuran_item
			drag_item.visible = false

func _ready():
	warna_awal = tombol1.modulate
	GlobalScript.inv.update.connect(update_slots)
	update_slots()

func _process(delta):
	if drag:
		if lok_pencet != get_global_mouse_position():
			drag_item.visible = true
		drag_item.z_index = 6
		print(drag_item.z_index)
		drag_item.global_position = get_global_mouse_position()

func _on_touch_screen_button_pressed():
	if GlobalScript.inv_is_open:
		if GlobalScript.select1 == null:
			GlobalScript.select1 = 8
		elif GlobalScript.select2 == null:
			GlobalScript.select2 = 8
		drag = true
		lok_pencet = get_global_mouse_position()
		get_texture(8)
	else:
		if use_item == true:
			use_item = false 
			GlobalScript.item_in_use = ""
			tombol1.modulate = warna_awal
			GlobalScript.slot_in_use = null
		else:
			if GlobalScript.inv.slots[8] != null:
				if GlobalScript.inv.slots[8].item != null:
					if GlobalScript.inv.slots[8].item.type == false:
						use_item = true
						GlobalScript.item_in_use = GlobalScript.inv.slots[8].item.name
						GlobalScript.slot_in_use = 8
						tombol1.modulate = Color("ffffff95")
	print(GlobalScript.item_in_use)

func _on_touch_screen_button_2_pressed():
	if GlobalScript.inv_is_open:
		if GlobalScript.select1 == null:
			GlobalScript.select1 = 9
		elif GlobalScript.select2 == null:
			GlobalScript.select2 = 9
		drag = true
		lok_pencet = get_global_mouse_position()
		get_texture(9)
	else:
		if use_item == true:
			use_item = false 
			GlobalScript.item_in_use = ""
			tombol2.modulate = warna_awal
			GlobalScript.slot_in_use = null
		else:
			if GlobalScript.inv.slots[9] != null:
				if GlobalScript.inv.slots[9].item != null:
					if GlobalScript.inv.slots[9].item.type == false:
						use_item = true
						GlobalScript.item_in_use = GlobalScript.inv.slots[9].item.name
						tombol2.modulate = Color("ffffff95")
						GlobalScript.slot_in_use = 9
	print(GlobalScript.item_in_use)

func _on_touch_screen_button_3_pressed():
	if GlobalScript.inv_is_open:
		if GlobalScript.select1 == null:
			GlobalScript.select1 = 10
		elif GlobalScript.select2 == null:
			GlobalScript.select2 = 10
		drag = true
		lok_pencet = get_global_mouse_position()
		get_texture(10)
	else:
		if use_item == true:
			use_item = false 
			GlobalScript.item_in_use = ""
			tombol3.modulate = warna_awal
			GlobalScript.slot_in_use = null
		else:
			if GlobalScript.inv.slots[10] != null:
				if GlobalScript.inv.slots[10].item != null:
					if GlobalScript.inv.slots[10].item.type == false:
						use_item = true
						GlobalScript.item_in_use = GlobalScript.inv.slots[10].item.name
						tombol3.modulate = Color("ffffff95")
						GlobalScript.slot_in_use = 10
	print(GlobalScript.item_in_use)

func more_item():
	GameEvent.emit_signal("tombol_more_inventory")

func _on_touch_screen_button_released():
	if GlobalScript.inv_is_open:
		if GlobalScript.select1 == null:
			pass
		elif GlobalScript.drag_loc != 8:
			GlobalScript.select2 = GlobalScript.drag_loc
		drag = false
		drag_item.texture = null

func _on_touch_screen_button_2_released():
	if GlobalScript.inv_is_open:
		if GlobalScript.select1 == null:
			pass
		elif GlobalScript.drag_loc != 9:
			GlobalScript.select2 = GlobalScript.drag_loc
		drag = false
		drag_item.texture = null

func _on_touch_screen_button_3_released():
	if GlobalScript.inv_is_open:
		if GlobalScript.select1 == null:
			pass
		elif GlobalScript.drag_loc != 10:
			GlobalScript.select2 = GlobalScript.drag_loc
		drag = false
		drag_item.texture = null



func _on_area_2d_mouse_entered():
	GlobalScript.drag_loc = 8
	print(GlobalScript.drag_loc)


func _on_area_2d_2_mouse_entered():
	GlobalScript.drag_loc = 9
	print(GlobalScript.drag_loc)


func _on_area_2d_3_mouse_entered():
	GlobalScript.drag_loc = 10
	print(GlobalScript.drag_loc)


func _on_area_2d_mouse_exited():
	GlobalScript.drag_loc = null


func _on_area_2d_2_mouse_exited():
	GlobalScript.drag_loc = null


func _on_area_2d_3_mouse_exited():
	GlobalScript.drag_loc = null
