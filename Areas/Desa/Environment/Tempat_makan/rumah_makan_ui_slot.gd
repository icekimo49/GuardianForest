extends Panel
@onready var scene = $"../../../../"

func _on_button_pressed():
	if GlobalScript.uang >= int($item_price.text) and scene.boleh_beli:
		var player = $"../../../../".get_node("Player")
		player.playerData.hp += int($item_benefit.text)
		player.playerData.uang -= int($item_price.text)
		scene.sudah_beli()
		scene.boleh_beli = false
