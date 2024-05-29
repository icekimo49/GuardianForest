extends Control

var detik = 0
var menit = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	reset_timer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if detik == 0:
		if menit == 0:
			GlobalScript.level_berakhir = true

func _on_timer_timeout():
	if detik == 0:
		if menit > 0:
			menit -=1
			detik = 59
	detik -=1
	if detik < 10:
		$Label.text = str(menit)+":"+"0"+str(detik)
	else:
		$Label.text = str(menit)+":"+str(detik)
	
	

func reset_timer():
	detik = 10
	menit = 0
