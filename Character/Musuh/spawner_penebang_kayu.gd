extends Node2D
#ini jeda munculnya
var min_time : int
var max_time : int
var random_time
var timer_duration
var penebang_kayu = preload("res://Character/Musuh/Penebang_kayu/Penebang_kayu.tscn")
var musuh
var timeout : bool
var playerData : PlayerData

func _ready():
	get_level()
	random()

func _process(delta):
	if timeout:
		random()
		timeout = false

func random():
	random_time = randi_range(min_time, max_time)
	start_timer(random_time)

func start_timer(duration):
	timer_duration = duration
	var timer = Timer.new()
	timer.set_wait_time(timer_duration)
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	add_child(timer)
	timer.one_shot = true
	timer.start()
	print("Timer dimulai dengan durasi: ", timer_duration, " detik")

func _on_timer_timeout():
	musuh = penebang_kayu.instantiate()
	musuh.global_position = self.global_position
	get_parent().add_child(musuh)
	timeout = true

func get_level():
	if playerData.wave == 1:
		max_time = 15
		min_time = 10
	elif playerData.wave == 2:
		max_time = 10
		min_time = 5
	elif playerData.wave == 3:
		max_time = 5
		min_time = 1
