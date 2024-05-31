extends CharacterBody2D

var speed = 200
var jarak
var kabur = false
@onready var nav = $NavigationAgent2D
@onready var api = preload("res://Areas/Hutan/Environment/Api/api.tscn")
var lok_api

func _ready():
	tujuan()

func _physics_process(delta):
	set_next_target()
	if nav.is_navigation_finished() == true and kabur == true:
		queue_free()
	if nav.distance_to_target() < 50.0:
		lok_api = nav.target_position
		nav.target_position = self.position
		lempar_api()
		kabur = true
	if kabur == true:
		nav.target_position = Vector2(1678.0, 79.0)

func tujuan():
		nav.target_position = GlobalScript.posisi_pohon[randi_range(0, GlobalScript.posisi_pohon.size()-1)]

func set_next_target():
	if nav.is_navigation_finished() == false:
		var next_target = nav.get_next_path_position()
		if nav.is_target_reachable() == false:
			tujuan()
			return
		velocity = global_position.direction_to(next_target) * speed
		move_and_slide()

func lempar_api():
	if kabur == false:
		var timer = Timer.new()
		add_child(timer)
		timer.wait_time = 2.0
		timer.one_shot = true
		timer.start()
		await timer.timeout
		var instance = api.instantiate()
		instance.position = lok_api
		get_parent().add_child(instance)
