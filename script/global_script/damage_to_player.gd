extends Node

func display_damage(value : int, position : Vector2):
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
	
