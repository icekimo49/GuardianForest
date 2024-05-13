extends Panel

@onready var item_visual : Sprite2D = $CenterContainer/Panel/item_display

func update(slot: InvSlot):
	if !slot.item :
		item_visual.visible = false
	else :
		item_visual.scale = Vector2(0.005,0.005)
		item_visual.visible = true
		item_visual.texture = slot.item.texture
