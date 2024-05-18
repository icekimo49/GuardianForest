extends Control
@onready var inv: Inv = preload ("res://script/inventory/playerinv.tres")
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
