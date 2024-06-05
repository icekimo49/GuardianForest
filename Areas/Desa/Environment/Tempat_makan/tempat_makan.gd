extends StaticBody2D

func _on_area_2d_body_entered(body):
	print("a")
	if body.has_method("player"):
		print("b")
		if GlobalScript.pencet == true:
			print("c")
			Dialogic.start("penjual_makanan_1")
