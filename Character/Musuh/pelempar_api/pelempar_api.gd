extends CharacterBody2D

var speed = 200
var jarak
var kabur = false
@onready var nav = $NavigationAgent2D
@onready var api = preload("res://Areas/Hutan/Environment/Api/api.tscn")
var lok_api
var boleh_gerak = true
var tutorial = false
var i = 0
var pohon_habis = false 

func _ready():
	if get_tree().current_scene.get_name() == "Hutan" and GlobalScript.sudah_tutorial == false:
		boleh_gerak = false
		tutorial = true
	if tutorial == false:
		tujuan()
	else:
		tujuan_tutorial()

func _physics_process(delta):
	if boleh_gerak:
		set_next_target()
		if nav.is_navigation_finished() == true and kabur == true:
			if tutorial == true:
				get_parent().get_parent().api_selesai_dilempar = true
			queue_free()
		if nav.distance_to_target() < 50.0:
			lok_api = nav.target_position
			nav.target_position = self.position
			await lempar_api()
			kabur = true
		if kabur == true:
			if tutorial:
				nav.target_position = Vector2(1784,-300)
			else:
				nav.target_position = Vector2(1678.0, 79.0)
			

func tujuan():
	nav.target_position = lokasi_pohon()

func lokasi_pohon():
	var keys = GlobalScript.posisi_pohon.keys()
	var random_index = randi_range(0, keys.size() - 1)
	var random_key = keys[random_index]
	var random_values = GlobalScript.posisi_pohon[random_key]
	if random_values.size() == 0:
		if random_key == "pohon":
			random_key = "pohon_kecil"
		elif random_key == "pohon_kecil":
			random_key = "pohon"
		random_values = GlobalScript.posisi_pohon[random_key]
		if random_values.size() == 0:
			pohon_habis = true
			return self.position 
		#tambahin game kalah kalo semua pohon udah habis disini
	var value_index = randi_range(0, random_values.size() -1)
	var random_value = random_values[value_index]
	return random_value

func set_next_target():
	if nav.is_navigation_finished() == false:
		var next_target = nav.get_next_path_position()
		if nav.is_target_reachable() == false:
			tujuan()
			return
		velocity = global_position.direction_to(next_target) * speed
		move_and_slide()

func tujuan_tutorial():
	nav.target_position = Vector2(1441, -119)

func kabur_tutorial():
	nav.target_position = Vector2(1784,-300)

func lempar_api():
	if kabur == false and pohon_habis == false:
		print("cihuy")
		var instance = api.instantiate()
		instance.position = lok_api
		if tutorial:
			instance.name = "api_tutorial"
			get_parent().get_parent().api_muncul = true
		get_tree().get_first_node_in_group("hutan").add_child(instance)
		if tutorial:
			instance.timer.stop()
