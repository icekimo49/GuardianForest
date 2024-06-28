extends Panel
var item_name
var price
@export var granat : InvItem
@export var biji : InvItem
@export var kentongan : InvItem
@export var ember : InvItem

func _on_button_pressed():
	if GlobalScript.uang >= price:
		var item
		if item_name == "kentongan":
			item = kentongan
		elif item_name == "biji":
			item = biji
		elif item_name == "granat_pemadam":
			item = granat
		elif item_name == "ember":
			item = ember
		$"../../../".get_node("Player").collect(item)
		GlobalScript.uang -= price
		print(GlobalScript.uang)
	else:
		print("uang tidak cukup")
