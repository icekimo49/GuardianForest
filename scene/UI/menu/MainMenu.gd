extends Control



func _on_main_pressed():
	get_tree().change_scene_to_file("res://scene/level/levelSelector/level_selector.tscn")


func _on_keluar_pressed():
	get_tree().quit()
