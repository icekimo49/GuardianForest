extends Control

func _ready():
	$kredit2.visible = false

func _on_kredit_pressed():
	$Node2D.visible = false
	$kredit2.visible = true
	$TouchScreenButton.visible = false
	$kredit2.get_node("CanvasLayer").get_node("Button").visible = true
	$kredit2.mulai()

func _on_keluar_pressed():
	get_tree().quit()

func _on_touch_screen_button_pressed():
	visible = false
	$"../../".tampil_setelah_pengaturan()
