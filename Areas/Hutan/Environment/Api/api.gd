extends CharacterBody2D

const maksKecepatan = 0
var timer: Timer
var HP = 1
var player_inattack_zone = false


# Called when the node enters the scene tree for the first time.
func _ready():
		timer = $Timer
		timer.start()

func _physics_process(delta):
	deal_damage()

func _on_timer_timeout():
	queue_free()
	pass

func api():
	pass
	#jangan diapus, penting!!!!

func _on_api_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true

func _on_api_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false

func deal_damage():
	if player_inattack_zone and GlobalScript.player_current_attack == true:
		HP -=1
		print(HP)
		if HP <= 0:
			self.queue_free()
