extends Control
#kalo ubah jumlah slot di playerinv, ubah kode juga di mini_inventory

@onready var slots : Array = $big_inventory/inventory_slot/GridContainer.get_children()
@onready var big_inventory = $big_inventory
@onready var drag_item = $drag_item
var mini_item_state : String
var drag : bool
var lok_pencet

func _ready():
	GameEvent.connect("tombol_more_inventory", Callable(self, "_mini_inventory"))
	GlobalScript.inv.update.connect(update_slots)
	update_slots()
	close()

func _mini_inventory() :
	kamera_ke_inventory_movement()

func _process(delta):
	GlobalScript.inv.update.connect(update_slots)
	update_slots()
	if Input.is_action_just_pressed("inventory_button") :
		kamera_ke_inventory_movement()
	if GlobalScript.select1 != null && GlobalScript.select2 != null:
		GlobalScript.inv.swap_item_slot(GlobalScript.select1, GlobalScript.select2)
		GlobalScript.select1 = null
		GlobalScript.select2 = null
		GlobalScript.drag_loc = null
		print("loh")
	if drag:
		if GlobalScript.select1:
			print("yewye")
			if lok_pencet != get_global_mouse_position():
				#print(GlobalScript.select1, GlobalScript.select2)
				if slots[GlobalScript.select1].item_visual.texture:
					slots[GlobalScript.select1].item_visual.visible = false
					slots[GlobalScript.select1].amount_text.visible = false
					drag_item.visible = true
			drag_item.z_index = 6
			drag_item.global_position = get_global_mouse_position()

func kamera_ke_inventory_movement():
	if GlobalScript.inv_is_open :
		close()
		GameEvent.emit_signal("kamera_ke_inventory", false)
	else :
		open()
		GameEvent.emit_signal("kamera_ke_inventory", true)

func update_slots():
	for i in range(min(GlobalScript.inv.slots.size(), slots.size())):
		slots[i].update(GlobalScript.inv.slots[i])

func open():
	big_inventory.visible = true
	GlobalScript.inv_is_open = true

func close():
	big_inventory.visible = false
	GlobalScript.inv_is_open = false

func get_texture(number):
	if GlobalScript.inv.slots[number].item:
		if !drag_item.texture:
			drag_item.texture = GlobalScript.inv.slots[number].item.texture
			drag_item.scale = GlobalScript.inv.slots[number].item.ukuran_item
			drag_item.visible = false

func _on_tombol_1_pressed():
	if GlobalScript.select1 == null:
		GlobalScript.select1 = 0
	elif GlobalScript.select2 == null:
		GlobalScript.select2 = 0
	else:
		GlobalScript.select1 = 0
		GlobalScript.select2 = null
	drag = true
	lok_pencet = get_global_mouse_position()
	get_texture(0)

func _on_tombol_2_pressed():
	if GlobalScript.select1 == null:
		GlobalScript.select1 = 1
	elif GlobalScript.select2 == null:
		GlobalScript.select2 = 1
	else:
		GlobalScript.select1 = 1
		GlobalScript.select2 = null
	drag = true
	lok_pencet = get_global_mouse_position()
	get_texture(1)

func _on_tombol_3_pressed():
	if GlobalScript.select1 == null:
		GlobalScript.select1 = 2
	elif GlobalScript.select2 == null:
		GlobalScript.select2 = 2
	else:
		GlobalScript.select1 = 2
		GlobalScript.select2 = null
	drag = true
	lok_pencet = get_global_mouse_position()
	get_texture(2)

func _on_tombol_4_pressed():
	if GlobalScript.select1 == null:
		GlobalScript.select1 = 3
	elif GlobalScript.select2 == null:
		GlobalScript.select2 = 3
	else:
		GlobalScript.select1 = 3
		GlobalScript.select2 = null
	drag = true
	lok_pencet = get_global_mouse_position()
	get_texture(3)

func _on_tombol_5_pressed():
	if GlobalScript.select1 == null:
		GlobalScript.select1 = 4
	elif GlobalScript.select2 == null:
		GlobalScript.select2 = 4
	else:
		GlobalScript.select1 = 4
		GlobalScript.select2 = null
	drag = true
	lok_pencet = get_global_mouse_position()
	get_texture(4)

func _on_tombol_6_pressed():
	if GlobalScript.select1 == null:
		GlobalScript.select1 = 5
	elif GlobalScript.select2 == null:
		GlobalScript.select2 = 5
	else:
		GlobalScript.select1 = 5
		GlobalScript.select2 = null
	drag = true
	lok_pencet = get_global_mouse_position()
	get_texture(5)

func _on_tombol_7_pressed():
	if GlobalScript.select1 == null:
		GlobalScript.select1 = 6
	elif GlobalScript.select2 == null:
		GlobalScript.select2 = 6
	else:
		GlobalScript.select1 = 6
		GlobalScript.select2 = null
	drag = true
	lok_pencet = get_global_mouse_position()
	get_texture(6)

func _on_tombol_8_pressed():
	if GlobalScript.select1 == null:
		GlobalScript.select1 = 7
	elif GlobalScript.select2 == null:
		GlobalScript.select2 = 7
	else:
		GlobalScript.select1 = 7
		GlobalScript.select2 = null
	drag = true
	lok_pencet = get_global_mouse_position()
	get_texture(7)

func _on_tombol_1_released():
	if GlobalScript.select1 == null:
		pass
	elif GlobalScript.drag_loc != 0:
		GlobalScript.select2 = GlobalScript.drag_loc
	elif GlobalScript.drag_loc == null:
		GlobalScript.select1 = null
	drag = false
	drag_item.texture = null

func _on_tombol_2_released():
	if GlobalScript.select1 == null:
		pass
	elif GlobalScript.drag_loc != 1:
		GlobalScript.select2 = GlobalScript.drag_loc
	elif GlobalScript.drag_loc == null:
		GlobalScript.select1 = null
	drag = false
	drag_item.texture = null

func _on_tombol_3_released():
	if GlobalScript.select1 == null:
		pass
	elif GlobalScript.drag_loc != 2:
		GlobalScript.select2 = GlobalScript.drag_loc
	elif GlobalScript.drag_loc == null:
		GlobalScript.select1 = null
	drag = false
	drag_item.texture = null

func _on_tombol_4_released():
	if GlobalScript.select1 == null:
		pass
	elif GlobalScript.drag_loc != 3:
		GlobalScript.select2 = GlobalScript.drag_loc
	elif GlobalScript.drag_loc == null:
		GlobalScript.select1 = null
	drag = false
	drag_item.texture = null

func _on_tombol_5_released():
	if GlobalScript.select1 == null:
		pass
	elif GlobalScript.drag_loc != 4:
		GlobalScript.select2 = GlobalScript.drag_loc
	elif GlobalScript.drag_loc == null:
		GlobalScript.select1 = null
	drag = false
	drag_item.texture = null

func _on_tombol_6_released():
	if GlobalScript.select1 == null:
		pass
	elif GlobalScript.drag_loc != 5:
		GlobalScript.select2 = GlobalScript.drag_loc
	elif GlobalScript.drag_loc == null:
		GlobalScript.select1 = null
	drag = false
	drag_item.texture = null

func _on_tombol_7_released():
	if GlobalScript.select1 == null:
		pass
	elif GlobalScript.drag_loc != 6:
		GlobalScript.select2 = GlobalScript.drag_loc
	elif GlobalScript.drag_loc == null:
		GlobalScript.select1 = null
	drag = false
	drag_item.texture = null

func _on_tombol_8_released():
	if GlobalScript.select1 == null:
		pass
	elif GlobalScript.drag_loc != 7:
		GlobalScript.select2 = GlobalScript.drag_loc
	elif GlobalScript.drag_loc == null:
		GlobalScript.select1 = null
	drag = false
	drag_item.texture = null

func _on_area_2d_mouse_entered():
	GlobalScript.drag_loc = 0
	print(GlobalScript.drag_loc)

func _on_area_2d_2_mouse_entered():
	GlobalScript.drag_loc = 1
	print(GlobalScript.drag_loc)

func _on_area_2d_3_mouse_entered():
	GlobalScript.drag_loc = 2
	print(GlobalScript.drag_loc)

func _on_area_2d_4_mouse_entered():
	GlobalScript.drag_loc = 3
	print(GlobalScript.drag_loc)

func _on_area_2d_5_mouse_entered():
	GlobalScript.drag_loc = 4
	print(GlobalScript.drag_loc)

func _on_area_2d_6_mouse_entered():
	GlobalScript.drag_loc = 5
	print(GlobalScript.drag_loc)

func _on_area_2d_7_mouse_entered():
	GlobalScript.drag_loc = 6
	print(GlobalScript.drag_loc)

func _on_area_2d_8_mouse_entered():
	GlobalScript.drag_loc = 7
	print(GlobalScript.drag_loc)

func _on_area_2d_mouse_exited():
	GlobalScript.drag_loc = null

func _on_area_2d_2_mouse_exited():
	GlobalScript.drag_loc = null

func _on_area_2d_3_mouse_exited():
	GlobalScript.drag_loc = null

func _on_area_2d_4_mouse_exited():
	GlobalScript.drag_loc = null

func _on_area_2d_5_mouse_exited():
	GlobalScript.drag_loc = null

func _on_area_2d_6_mouse_exited():
	GlobalScript.drag_loc = null

func _on_area_2d_7_mouse_exited():
	GlobalScript.drag_loc = null

func _on_area_2d_8_mouse_exited():
	GlobalScript.drag_loc = null
