extends Control
@onready var inv: Inv = preload ("res://script/inventory/playerinv.tres")
@onready var slots : Array = $inventory_slot/GridContainer.get_children()

func _ready():
	close()


func _process(delta):
	if Input.is_action_just_pressed("inventory_button"):
		if GlobalScript.inv_is_open :
			close()
			GameEvent.emit_signal("kamera_ke_inventory", false)
		else :
			open()
			GameEvent.emit_signal("kamera_ke_inventory", true)



func open():
	visible = true
	GlobalScript.inv_is_open = true
	
func close():
	visible = false
	GlobalScript.inv_is_open = false
