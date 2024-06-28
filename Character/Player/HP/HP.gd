extends NinePatchRect

@onready var hp = $ProgressBar
@onready var label = $Label
@onready var circular = $TextureProgressBar

var player

func _process(delta):
	player = $"../../Ysort/Player"
	if player == null:
		player = get_parent().player
	if player:
		update()

func update():
	if !player:
		hp.value = 0
	else:
		hp.value = player.playerData.hp
	if GlobalScript.item_in_use == "ember":
		label.text = str(GlobalScript.isi_air_gayung)
	elif GlobalScript.item_in_use == "biji":
		label.text = str(GlobalScript.inv.slots[GlobalScript.slot_in_use].amount)
	else:
		label.text = ""
	
