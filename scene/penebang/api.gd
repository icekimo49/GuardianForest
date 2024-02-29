extends CharacterBody2D

const maksKecepatan = 0
var timer: Timer
var HP = 1
var player_inattack_zone = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.area_entered.connect(on_area_entered)
	timer = $Timer
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var arah = arah_kePlayer()
	velocity = arah * maksKecepatan
	move_and_slide()

func _physics_process(delta):
	deal_damage()

func arah_kePlayer():
	var player_nodes = get_tree().get_first_node_in_group("player") as Node2D
	if (player_nodes != null):
		return (player_nodes.global_position - global_position).normalized()
		
	return Vector2.ZERO


func on_area_entered(other_area : Area2D):
	queue_free()


func _on_timer_timeout():
	#queue_free()
	pass

func api():
	pass
	#jangan diapus, penting!!!!

func _on_api_hitbox_body_entered(body):
	#ubah persyaratan if buat ganti tipe senjatanya dari player ke gayung dsb
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
