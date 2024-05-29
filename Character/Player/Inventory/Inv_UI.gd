extends Control
#kalo ubah jumlah slot di playerinv, ubah kode juga di mini_inventory
@onready var inv: Inv = preload ("res://Character/Player/Inventory/playerinv.tres")
@onready var slots : Array = $big_inventory/inventory_slot/GridContainer.get_children()
@onready var big_inventory = $big_inventory
var mini_item_state : String

func _ready():
	GameEvent.connect("tombol_more_inventory", Callable(self, "_mini_inventory"))
	inv.update.connect(update_slots)
	update_slots()
	close()

func _mini_inventory() :
	kamera_ke_inventory_movement()

func _process(delta):
	if Input.is_action_just_pressed("inventory_button") :
		kamera_ke_inventory_movement()
	if GlobalScript.select1 != null && GlobalScript.select2 != null:
		inv.swap_item_slot(GlobalScript.select1, GlobalScript.select2)
		GlobalScript.select1 = null
		GlobalScript.select2 = null

func kamera_ke_inventory_movement():
	if GlobalScript.inv_is_open :
		close()
		GameEvent.emit_signal("kamera_ke_inventory", false)
	else :
		open()
		GameEvent.emit_signal("kamera_ke_inventory", true)

func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])

func open():
	big_inventory.visible = true
	GlobalScript.inv_is_open = true

func close():
	big_inventory.visible = false
	GlobalScript.inv_is_open = false

func _on_tombol_1_pressed():
	if GlobalScript.select1 == null:
		GlobalScript.select1 = 0
	elif GlobalScript.select2 == null:
		GlobalScript.select2 = 0
	else:
		GlobalScript.select1 = 0
		GlobalScript.select2 = null
	print(GlobalScript.select1)
	print(GlobalScript.select2)

func _on_tombol_2_pressed():
	if GlobalScript.select1 == null:
		GlobalScript.select1 = 1
	elif GlobalScript.select2 == null:
		GlobalScript.select2 = 1
	else:
		GlobalScript.select1 = 1
		GlobalScript.select2 = null
	print(GlobalScript.select1)
	print(GlobalScript.select2)

func _on_tombol_3_pressed():
	if GlobalScript.select1 == null:
		GlobalScript.select1 = 2
	elif GlobalScript.select2 == null:
		GlobalScript.select2 = 2
	else:
		GlobalScript.select1 = 2
		GlobalScript.select2 = null
	print(GlobalScript.select1)
	print(GlobalScript.select2)

func _on_tombol_4_pressed():
	if GlobalScript.select1 == null:
		GlobalScript.select1 = 3
	elif GlobalScript.select2 == null:
		GlobalScript.select2 = 3
	else:
		GlobalScript.select1 = 3
		GlobalScript.select2 = null
	print(GlobalScript.select1)
	print(GlobalScript.select2)

func _on_tombol_5_pressed():
	if GlobalScript.select1 == null:
		GlobalScript.select1 = 4
	elif GlobalScript.select2 == null:
		GlobalScript.select2 = 4
	else:
		GlobalScript.select1 = 4
		GlobalScript.select2 = null
	print(GlobalScript.select1)
	print(GlobalScript.select2)

func _on_tombol_6_pressed():
	if GlobalScript.select1 == null:
		GlobalScript.select1 = 5
	elif GlobalScript.select2 == null:
		GlobalScript.select2 = 5
	else:
		GlobalScript.select1 = 5
		GlobalScript.select2 = null
	print(GlobalScript.select1)
	print(GlobalScript.select2)

func _on_tombol_7_pressed():
	if GlobalScript.select1 == null:
		GlobalScript.select1 = 6
	elif GlobalScript.select2 == null:
		GlobalScript.select2 = 6
	else:
		GlobalScript.select1 = 6
		GlobalScript.select2 = null
	print(GlobalScript.select1)
	print(GlobalScript.select2)

func _on_tombol_8_pressed():
	if GlobalScript.select1 == null:
		GlobalScript.select1 = 7
	elif GlobalScript.select2 == null:
		GlobalScript.select2 = 7
	else:
		GlobalScript.select1 = 7
		GlobalScript.select2 = null
	print(GlobalScript.select1)
	print(GlobalScript.select2)
