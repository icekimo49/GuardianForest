extends StaticBody2D
var buka = false

func _on_area_2d_body_entered(body):
	print("a")
	if body.has_method("player"):
		print("b")
		buka = true

func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		buka = false

func _process(delta):
	if buka == true and GlobalScript.pencet:
		get_parent().ui_tempat_makan()
