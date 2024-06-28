extends Sprite2D

var bisa_interaksi = false

func _on_area_2d_body_entered(body):
	bisa_interaksi = true

func _on_area_2d_body_exited(body):
	bisa_interaksi = false

func _process(delta):
	if GlobalScript.pencet and bisa_interaksi:
		bisa_interaksi = false
		var opsi = randi_range(1, 3)
		var layout = Dialogic.start("mbokyem_" + str(opsi))
		layout.register_character(load("res://Dialogic/Player/mbok_yem.dch"), $".")
		await get_tree().create_timer(2).timeout
		Dialogic.Inputs.auto_skip.enabled = !Dialogic.Inputs.auto_skip.enabled
		
