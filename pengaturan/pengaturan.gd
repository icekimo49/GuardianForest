extends Control

func _ready():
	$kredit2.visible = false

func _on_kredit_pressed():
	$Node2D.visible = false
	$kredit2.visible = true
	$kredit2.mulai()

func _on_keluar_pressed():
	get_tree().quit()
