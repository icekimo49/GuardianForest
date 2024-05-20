extends Area2D


@onready var big_Circle = $bigCircle
@onready var small_Circle = $bigCircle/smallCircle
@onready var max_distance = $CollisionShape2D.shape.radius

var touched : bool = false
var arah_baru
var arah_lama

var enable_analog  = true

func _input(event):
	if !enable_analog :
		return
	if event is InputEventScreenTouch:
		if GlobalScript.inv_is_open == false:
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
	if c == 0:
		arah_baru = arah_lama
	elif c < 45 && c > -45:
		arah_baru = "kanan"
	elif c < 135 && c > 45:
		arah_baru = "bawah"
	elif c > -135 && c < -45:
		arah_baru = "atas"
	elif c < -135 || c > 135:
		arah_baru = "kiri"
	arah_lama = arah_baru
	return arah_baru
	
	
func get_velo():
	var joy_velo = Vector2.ZERO
	joy_velo.x = small_Circle.position.x / max_distance
	joy_velo.y= small_Circle.position.y / max_distance
	return joy_velo
		

