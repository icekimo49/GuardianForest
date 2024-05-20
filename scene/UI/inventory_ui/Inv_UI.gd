extends Control
@onready var inv: Inv = preload ("res://script/inventory/playerinv.tres")
@onready var slots : Array = $big_inventory/inventory_slot/GridContainer.get_children()

@onready var big_inventory = $big_inventory

var mini_item_state : String
var select1 = null
var select2 = null

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

func select_item():
	pass

func _on_tombol_1_pressed():
	if select1 == null:
		select1 = 0
	elif select2 == null:
		select2 = 0
	else:
		select1 = 0
		select2 = null
	print("Tombol 1")


func _on_tombol_2_pressed():
	if select1 == null:
		select1 = 1
	elif select2 == null:
		select2 = 1
	else:
		select1 = 1
		select2 = null
		print("Tombol 2")

func _on_tombol_3_pressed():
	if select1 == null:
		select1 = 2
	elif select2 == null:
		select2 = 2
	else:
		select1 = 2
		select2 = null
	print('Tombol 3')
	
func _on_tombol_4_pressed():
	if select1 == null:
		select1 = 3
	elif select2 == null:
		select2 = 3
	else:
		select1 = 3
		select2 = null
	print("Tombol 4")

func _on_tombol_5_pressed():
	if select1 == null:
		select1 = 4
	elif select2 == null:
		select2 = 4
	else:
		select1 = 4
		select2 = null
	print("Tombol 5")
	

func _on_tombol_6_pressed():
	if select1 == null:
		select1 = 5
	elif select2 == null:
		select2 = 5
	else:
		select1 = 5
		select2 = null
	print("Tombol 6")
	
func _on_tombol_7_pressed():
	if select1 == null:
		select1 = 6
	elif select2 == null:
		select2 = 6
	else:
		select1 = 6
		select2 = null
	print("Tombol 7")
	
func _on_tombol_8_pressed():
	if select1 == null:
		select1 = 7
	elif select2 == null:
		select2 = 7
	else:
		select1 = 7
		select2 = null
	print("Tombol 8")
