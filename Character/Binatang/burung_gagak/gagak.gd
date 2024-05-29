extends AnimatedSprite2D

var state = "DIAM"
@onready var suara = $AudioStreamPlayer2D
var random
@onready var kanan = $Kanan
@onready var kiri = $Kiri

# Called when the node enters the scene tree for the first time.
func _ready():
	set_random_animasi()
	

func set_random_animasi():
	random = randi_range(1,2)
	if random == 1:
		play("makan")
		state = "MAKAN"
	else :
		play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state != "KABUR":
		return
	if random == 1:
		global_position = lerp(global_position, kanan.global_position, delta  * 0.6 )
	else:
		global_position = lerp(global_position, kiri.global_position, delta * 0.6)

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		state = "KABUR"
		suara.play()
