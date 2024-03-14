extends CharacterBody2D


#Path Finding Stuff
var PFspeed = 150 #PF = PathFinding
@export var navAgent : NavigationAgent2D
var target_node = null
var home_position = Vector2.ZERO

var speed = 1000
var kabur = false
var player = null
var arahRandom = randf()
@onready var timer = $Timer
var array_posisi_pohon = GlobalScript.posisi_pohon
var aselole = false
var angka_acak = RandomNumberGenerator.new()
var tet


func _ready():
	#PathFinding Stuff
	#home_position = self.global_position
	#navAgent.path_desired_distance = 4
	#navAgent.target_desired_distance = 4
	
	print(array_posisi_pohon[angka_acak.randi_range(0, array_posisi_pohon.size()-1)])
	pass

func _physics_process(delta):
	if aselole == false:
		tet = rng()
	print(tet)
	if kabur:
		var positionLimit = position
		var target_positionLimit = Vector2(array_posisi_pohon[tet].x, array_posisi_pohon[tet].y)
		#print(positionLimit)
		if (positionLimit.x <=  array_posisi_pohon[tet].x && positionLimit.y != target_positionLimit.y) :
			var start_position = position
			var target_position = Vector2(array_posisi_pohon[tet].x, array_posisi_pohon[tet].y)  # Ubah posisi tujuan sesuai kebutuhan Anda
			var direction = (target_position - start_position).normalized()
			position += direction * speed * delta
	
	#PathFinding Stuff
	#if (navAgent.is_navigation_finished()):
		return
	#var axis = to_local(navAgent.get_next_path_position()).normalized()
	#velocity = axis * speed
	move_and_slide()
	
func pembuatRandom() -> float :
	var x = 1000
	if randf() < 0.5:
		x = -1000
	return x

func rng():
	if aselole == false:
		angka_acak.randomize()
		var rng = angka_acak.randi_range(0, array_posisi_pohon.size()-1)
		aselole = true
		print(rng)
		return rng

func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		player = body
		kabur = true
		timer.start()

#Ngilangin musuh setelah kabur
func _on_timer_timeout():
	$".".queue_free()

#PathFinding Stuff
func recalc_path():
	#if (target_node && is_instance_valid($".")):
		#navAgent.target_position = target_node.global_position
	#elif (is_instance_valid($".")) :
		#navAgent.target_position = home_position
	pass

func _on_pathfinding_timer_timeout():
	recalc_path()


func _on_lingkar_jauh_area_entered(area):
	target_node = area.owner


func _on_lingkar_dekat_area_entered(area):
	if (area.owner == target_node):
		target_node = null

func penebang_kayu():
	pass

