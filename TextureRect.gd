extends TextureRect

func _get_drag_data(at_position):
	return texture

func _can_drop_data(at_position, data):
	return data is Texture

func _drop_data(at_position, data):
	
