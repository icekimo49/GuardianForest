extends Area2D


@onready var big_Circle = $bigCircle
@onready var small_Circle = $bigCircle/smallCircle
@onready var max_distance = $CollisionShape2D.shape.radius

var touched : bool = false


func _input(event):
	if event is InputEventScreenTouch:
		var distance = event.position.distance_to(big_Circle.global_position)
		if not touched:
			if distance < max_distance :
				touched = true
		else :
			small_Circle.position = Vector2.ZERO
			touched = false
			
func _process(delta):
	if touched :
		small_Circle.global_position = get_global_mouse_position()
		#CLAMPER
		#small_Circle.position = big_Circle.position + (small_Circle.position - big_Circle.position).limit_length(max_distance)


func arah():
	var a = Vector2.RIGHT
	var b = Vector2(small_Circle.position.x / max_distance, small_Circle.position.y / max_distance)
	var c = rad_to_deg(a.angle_to(b))
	var arah
	if c < 45 && c > -45:
		arah = "kanan"
	elif c < 135 && c > 45:
		arah = "bawah"
	elif c > -135 && c < -45:
		arah = "atas"
	elif c < -135 || c > 135:
		arah = "kiri"
	return arah
	
	
func get_velo():
	var joy_velo = Vector2.ZERO
	joy_velo.x = small_Circle.position.x / max_distance
	joy_velo.y= small_Circle.position.y / max_distance
	return joy_velo
		

