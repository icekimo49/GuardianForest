extends Panel

@onready var item_visual : Sprite2D = $CenterContainer/Panel/tampilan_item

func update(slots: InvSlot):
	if !slots.item :
		item_visual.visible = false
	else :
		item_visual.scale = Vector2(0.005,0.005)
		item_visual.visible = true
		item_visual.texture = slots.item.texture
