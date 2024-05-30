extends Node2D
#ini jeda munculnya
var min_time : int
var max_time : int
var random_time
var timer_duration
var penebang_kayu = preload("res://Character/Musuh/Penebang_kayu/Penebang_kayu.tscn")
var musuh
var timeout : bool
var timer = Timer.new()

func _ready():
	timeout = true

func _process(delta):
	if GlobalScript.game_berlangsung == false:
		timer.stop()
	if GlobalScript.game_berlangsung and timeout:
		jeda_muncul()
		random()
		timeout = false

func random():
	random_time = randf_range(min_time, max_time)
	start_timer(random_time)

func start_timer(duration):
	timer_duration = duration
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

func jeda_muncul():
	max_time = 15.0 / GlobalScript.tingkat_wave
	min_time = 12.0 / GlobalScript.tingkat_wave
