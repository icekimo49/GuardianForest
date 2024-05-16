extends Panel

@onready var item_visual : Sprite2D = $CenterContainer/Panel/item_display
@onready var amount_text: Label = $CenterContainer/Panel/Label

func update(slot: InvSlot):
	if !slot.item :
		item_visual.visible = false
		amount_text.visible = false
	elif slot.item.type == true:
		item_visual.scale = Vector2(0.005,0.005)
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		amount_text.visible = true
		amount_text.text = str(slot.amount)
	else:
		item_visual.scale = Vector2(0.005,0.005)
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		amount_text.visible = false
		amount_text.text = str(slot.amount)
