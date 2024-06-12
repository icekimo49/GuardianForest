extends NinePatchRect

@onready var hp = $ProgressBar
@onready var label = $Label
@onready var circular = $TextureProgressBar

var player

func _ready():
	player = get_parent().get_parent().get_node("Player")
	
func _process(delta):
	update()

func update():
	hp.value = player.playerData.hp
	if GlobalScript.item_in_use == "ember":
		label.text = str(GlobalScript.isi_air_gayung)
	elif GlobalScript.item_in_use == "biji":
		label.text = str(GlobalScript.inv.slots[GlobalScript.slot_in_use].amount)
	else:
		label.text = ""
	
