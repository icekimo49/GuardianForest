extends Area2D


@onready var big_Circle = $bigCircle
@onready var small_Circle = $bigCircle/smallCircle
@onready var max_distance = $CollisionShape2D.shape.radius
@onready var max_distance2 = $buatsmallcircle.shape.radius
var jarak_small_circle_max
var small_circle_posisi_awal
var touched : bool = false
var arah_baru
var arah_lama
var i = 1
var enable_analog  = true
var no_input = false

func _ready():
	small_circle_posisi_awal = $bigCircle/smallCircle.global_position

var state = {}

func _unhandled_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			state[event.index] = event.position
		else:
			state.erase(event.index)
		get_viewport().set_input_as_handled()
	elif event is InputEventScreenDrag:
		state[event.index] = event.position
		get_viewport().set_input_as_handled()

func _input(event):
	#if event is InputEventScreenTouch:
		#if GlobalScript.inv_is_open == false:
			#var distance = event.position.distance_to(big_Circle.global_position)
			#if not touched:
				#if distance < max_distance :
					#touched = true
			#else :
				#small_Circle.position = Vector2.ZERO
				#touched = false
	pass

func _process(delta):
	var pos
	var multitouch = state
	if !enable_analog :
		return
	for ptr_index in multitouch.keys():
		if GlobalScript.inv_is_open == false:
			pos = multitouch[ptr_index]
			var distance = pos.distance_to(big_Circle.global_position)
			if not touched:
				if distance < max_distance:
					touched = true
				else:
					small_Circle.position = Vector2.ZERO
					touched = false
	if touched and no_input == false:
		if pos != null:
				if pos.distance_to(big_Circle.global_position) < max_distance:
					small_Circle.global_position = pos
			#CLAMPER
					small_Circle.position = big_Circle.position + (small_Circle.position - big_Circle.position).limit_length(max_distance2)
				else: 
					touched = false
		elif pos == null:
			small_Circle.position = Vector2.ZERO
			touched = false
	

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
		

