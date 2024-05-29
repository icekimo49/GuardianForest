extends Sprite2D

@onready var pintu = $Pintu

var state = "DIAM" #ada BUKA, TUTUP, DIAM

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if state == "DIAM":
		return
	if state == "BUKA":
		pintu.flip_h == true
		pintu.scale.x = lerp(pintu.scale.x, -1.0, get_process_delta_time())
	elif state == "TUTUP":
		pintu.flip_h == false
		pintu.scale.x = lerp(pintu.scale.x, 1.0, get_process_delta_time())
		
func _on_deteksi_pintu_body_entered(body):
	if body.is_in_group("player"):
		state = "BUKA"

func _on_deteksi_pintu_body_exited(body):
	if body.is_in_group("player"):
		state = "TUTUP"
