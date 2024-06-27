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

func deal_damage():
	if player_inattack_zone and GlobalScript.player_current_attack == true:
		HP -=1
		print(HP)
		if HP <= 0:
			self.queue_free()

func _on_api_hitbox_area_entered(area):
	print("nama" + area.name)
	if area.name != "player_hitbox":
		player_inattack_zone = true
		print("ril")

func _on_api_hitbox_area_exited(area):
	if area.name != "player_hitbox":
		player_inattack_zone = false
		print("fake")
