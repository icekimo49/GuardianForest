extends CanvasModulate

const minute_per_day = 1440
const minute_per_hour = 60
const ingame_to_real_minute_duration = (2 * PI) / minute_per_day
var time_stop = false

signal time_tick(day:int, hour:int, minute:int)

@export var gradient:GradientTexture1D
@export var ingame_time_speed = 1.0
@export var initial_hour = 12:
	set(h):
		initial_hour = h
		GlobalScript.time = ingame_to_real_minute_duration * initial_hour * minute_per_hour

var past_minute:float = -1.0

func _ready():
	pass

func _process(delta:float):
	if time_stop == false:
		GlobalScript.time += delta * ingame_to_real_minute_duration * ingame_time_speed
		var value = (sin(GlobalScript.time - PI / 2) + 1.0) / 2.0
		self.color = gradient.gradient.sample(value)
		_recalculate_time()

func _recalculate_time():
	var total_minutes = int(GlobalScript.time / ingame_to_real_minute_duration)
	
	var day = int(total_minutes / minute_per_day)
	
	var current_day_minutes = total_minutes % minute_per_day
	
	var hour = int(current_day_minutes / minute_per_hour)
	var minute = int(current_day_minutes % minute_per_hour)
	GlobalScript.hour = hour
	if past_minute != minute:
		past_minute = minute
		time_tick.emit(day, hour, minute)
