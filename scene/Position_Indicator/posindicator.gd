extends Node2D

@onready var indicator =$indicator
@onready var i
signal offscreen
signal onscreen
func _process(_delta):
	var canvas = get_canvas_transform() 
	var top_left = -canvas.origin/canvas.get_scale()
	var size = get_viewport_rect().size /canvas.get_scale()
	
	
	set_pos(Rect2(top_left,size))
	set_the_rotation()
	
	
func set_pos(bounds:Rect2):
	indicator.global_position.x = clamp(global_position.x,bounds.position.x,bounds.end.x)
	indicator.global_position.y = clamp(global_position.y,bounds.position.y,bounds.end.y)
	
	if bounds.has_point(global_position):
		hide()
		emit_signal("onscreen")
	else:
		emit_signal("offscreen")
		show()

func set_the_rotation():
	var angle = (global_position-indicator.global_position).angle()
	indicator.global_rotation = angle
	
