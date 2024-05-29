extends CanvasLayer

@export var arena_timer_manager : Node
@onready var label = $%TextLabel

func _process(delta):
	if arena_timer_manager == null:
		return
	var timer = arena_timer_manager.waktu_terbuang()
	label.text = str(format_waktu_ke_string(timer))
	
func format_waktu_ke_string(waktuDetik : float):
	var menit = floor(waktuDetik / 60)
	var detik = waktuDetik - (menit * 60)
	return str(menit) + ":"  + ("%02d"% floor(detik))
	
