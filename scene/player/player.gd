extends CharacterBody2D

const kecepatan : int = 250
const akselerasi  = 25
var hp = 100
var api_inattack_range = false
var api_attack_cooldown = true
var player_alive = true
var attack_in_progress = false
var animasi_player
var a = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var arah = get_movement_vector()
	var arahNormalized = arah.normalized()
	velocity = arahNormalized * kecepatan
	#var target_velocity = arahNormalized  *kecepatan
	#velocity = velocity.lerp(target_velocity, 1 - exp(-delta * akselerasi))
	move_and_slide()
	
	#Controller 
	velocity = $"../UI/joystick".get_velo().normalized() * kecepatan
	animasi_player = $"../UI/joystick".arah()
	if animasi_player == "kiri":
		animasi(1)
	elif animasi_player == "kanan":
		animasi(1)
	elif animasi_player == "atas":
		animasi(1)
	elif animasi_player == "bawah":
		animasi(1)
	elif animasi_player == "diam":
		animasi(1)
	move_and_slide()
	pass

func animasi(movement):
	var arah = animasi_player
	var anim = $AnimatedSprite2D
	if arah == "kiri":
		if attack_in_progress == false:
			if movement == 1:
				anim.play("kiri")
			elif movement == 0:
				anim.play("diam_kiri") 
	if arah == "kanan":
		if attack_in_progress == false:
			if movement == 1:
				anim.play("kanan")
			elif movement == 0:
				anim.play("diam_kanan")
	if arah == "atas":
		if attack_in_progress == false:
			if movement == 1:
				anim.play("atas")
			elif movement == 0:
				anim.play("diam_atas")
	if arah == "bawah":
		if attack_in_progress == false:
			if movement == 1:
				anim.play("bawah")
			elif movement == 0:
				anim.play("diam_bawah")
	if arah == "diam":
		if movement == 1:
			anim.play("diam_bawah")
	pass
func _physics_process(delta):
	api_attack()
	attack()
	
	if hp <= 0:
		player_alive = false #pindah ke main menu
		hp = 0
		self.queue_free()
		
func get_movement_vector():
	var inputX = Input.get_action_strength("ui_kanan")-Input.get_action_strength("ui_kiri")
	var inputY = Input.get_action_strength("ui_bawah")-Input.get_action_strength("ui_atas")
	return Vector2(inputX, inputY)

func player():
	pass
	#jangan diapus, penting!!!!

func _on_player_hitbox_body_entered(body):
	if body.has_method("api"):
		api_inattack_range = true
		api_attack()

func _on_player_hitbox_body_exited(body):
	if body.has_method("api"):
		api_inattack_range = false

func api_attack():
	if api_inattack_range and api_attack_cooldown == true:
		hp -= 20
		api_attack_cooldown = false
		$api_cooldown.start()
		print(hp)

func _on_api_cooldown_timeout():
	api_attack_cooldown = true

func attack():
	var arah = animasi_player
	if GlobalScript.pencet:
		GlobalScript.player_current_attack = true
		attack_in_progress = true
		a+=1
		print(a)
		if arah == "kanan":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("serang_kanan")
			$deal_attack_timer.start()
		if arah == "kiri":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("serang_kanan")
			$deal_attack_timer.start()
		if arah == "bawah":
			$AnimatedSprite2D.play("serang_bawah")
			$deal_attack_timer.start()
		if arah == "atas":
			$AnimatedSprite2D.play("serang_atas")
			$deal_attack_timer.start()
	GlobalScript.pencet = false




func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	GlobalScript.player_current_attack = false
	attack_in_progress = false
