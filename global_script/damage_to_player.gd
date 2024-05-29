extends Node

func display_damage(value : int, position : Vector2): #Hello World, ini adalah easter egg
	var damage = Label.new()
	damage.global_position = position
	damage.text = str(value)
	damage.z_index = 5
	damage.label_settings = LabelSettings.new()
	
	var color = "#A0153E"
	damage.label_settings.font_color = color
	damage.label_settings.font_size = 10
	damage.label_settings.outline_color = "#000"
	damage.label_settings.outline_size = 1
	
	call_deferred("add_child", damage)
	
	await damage.resized
	damage.pivot_offset = Vector2(damage.size/2)
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(damage, "position:y", damage.position.y - 24, 0.25).set_ease(Tween.EASE_OUT)
	tween.tween_property(damage, "position:y", damage.position.y, 0.5 ).set_ease(Tween.EASE_IN).set_delay(0.25)
	tween.tween_property(damage, "scale", Vector2.ZERO, 0.25).set_ease(Tween.EASE_IN).set_delay(0.5)
	await tween.finished
	
	damage.queue_free()
	
func display_air(isi : String, position : Vector2):
	var air = Label.new()
	air.global_position = position
	air.text = isi
	air.z_index = 5
	air.label_settings = LabelSettings.new()
	
	var color = "#67C6E3"
	air.label_settings.font_color = color
	air.label_settings.font_size = 10
	air.label_settings.outline_color = "#000"
	air.label_settings.outline_size = 1
	
	call_deferred("add_child", air)
	
	await air.resized
	air.pivot_offset = Vector2(air.size/2)
	
	var tween = get_tree().create_tween()
	tween.tween_property(air, "position:y", air.position.y-24, 0.25).set_ease(Tween.EASE_OUT)
	tween.tween_property(air, "position:y", air.position.y, 0.5).set_ease(Tween.EASE_IN).set_delay(0.25)
	tween.tween_property(air, "scale", Vector2.ZERO, 0.25).set_ease(Tween.EASE_OUT).set_delay(0.25)
	await tween.finished
	air.queue_free()
