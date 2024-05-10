extends Control

@onready var inventory : inventoryManager = preload("res://script/inventory/player_inventory.tres")
@onready var slot_inventory : Array = $inventory_slot/GridContainer.get_children()

func _ready():
	update_slots()
	tutup()
	
func _process(delta):
	if Input.is_action_just_pressed("inventory_button"):
		if GlobalScript.inv_is_open :
			tutup()
			GameEvent.emit_signal("kamera_ke_inventory", false)
		else :			
			buka()
			GameEvent.emit_signal("kamera_ke_inventory", true)
	
func update_slots():
	for i in range(min(inventory.items.size(),slot_inventory.size())):
		slot_inventory[i].update(inventory.items[i])

func buka():
	visible = true
	GlobalScript.inv_is_open = true
	
func tutup():
	visible = false
	GlobalScript.inv_is_open = false
