extends CharacterBody2D

const kecepatan : int = 250
const akselerasi  = 25
var hp = 100
var kerusakan = 20 #Damage api
var maksHP = 100
var api_inattack_range = false
var api_attack_cooldown = true
var player_alive = true
var attack_in_progress = false
var animasi_player
var a = 1
var posisi_lama
@onready var barDarah = $barDarah
@onready var textDamage = $damage_diterima
@onready var textAir = $airIndikator

@export var inv: Inv

func notif_air_habis():
	DamageToPlayer.display_air("Air Habis!", textDamage.global_position)

func display_darah_player(): #Buat nampilin sisa darah player
	barDarah.value = hp

func display_air_indikator(): #Buat nampilin jumlah sisa air
	textAir.text = str(GlobalScript.isi_air_gayung) 

# Called when the node enters the scene tree for the first time.
func _ready():
	display_darah_player()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	display_air_indikator()
	#var arah = get_movement_vector()
	#var arahNormalized = arah.normalized()
	#velocity = arahNormalized * kecepatan
		##Sebelumnya Nggak dipake
		##var target_velocity = arahNormalized  *kecepatan
		##velocity = velocity.lerp(target_velocity, 1 - exp(-delta * akselerasi))
	#move_and_slide()
	
	#Movement pake Keyboard versi 2 (Biar bisa animasi)
	velocity = Vector2.ZERO
	if(Input.is_action_pressed("ui_kanan")): 
		var anim = $AnimatedSprite2D
		velocity.x += 1
		if attack_in_progress == false:
			anim.play("kanan")
	elif(Input.is_action_just_released("ui_kanan",true)):
		$AnimatedSprite2D.play("diam_kanan")
	if(Input.is_action_pressed("ui_kiri")):
		var anim = $AnimatedSprite2D
		velocity.x -= 1
		if attack_in_progress == false:
			anim.play("kiri")
	elif(Input.is_action_just_released("ui_kiri",true)):
		$AnimatedSprite2D.play("diam_kiri")
	if(Input.is_action_pressed("ui_atas")):
		var anim = $AnimatedSprite2D 
		velocity.y -= 1
		if attack_in_progress == false:
			anim.play("atas")
	elif(Input.is_action_just_released("ui_atas",true)):
		$AnimatedSprite2D.play("diam_atas")
	if(Input.is_action_pressed("ui_bawah")):
		velocity.y += 1
		if attack_in_progress == false:
			$AnimatedSprite2D.play("bawah")
	elif(Input.is_action_just_released("ui_bawah",true)):
		$AnimatedSprite2D.play("diam_bawah")
	velocity = velocity.normalized() * kecepatan
	#print(velocity)
	move_and_slide()
	
	#Controller 
	velocity = $"../UI/joystick".get_velo().normalized() * kecepatan
	animasi_player = $"../UI/joystick".arah()
	var posisi_baru = self.global_position
	if posisi_baru != posisi_lama:
		animasi(1)
	elif posisi_baru == posisi_lama:
		animasi(0)
	posisi_lama = posisi_baru
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
			if movement == 0:
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
		hp -= kerusakan
		display_darah_player() #Update Value Bar Darah
		DamageToPlayer.display_damage(kerusakan, textDamage.global_position) #Nampilin Damage
		api_attack_cooldown = false
		$api_cooldown.start()
		print(hp)

func _on_api_cooldown_timeout():
	api_attack_cooldown = true

func attack():
	var arah = animasi_player
	if GlobalScript.inv_is_open == false:
		if GlobalScript.pencet && GlobalScript.isi_air_gayung == 0:#notif ammo habis
			notif_air_habis()
		if GlobalScript.pencet && GlobalScript.isi_air_gayung > 0:
			GlobalScript.player_current_attack = true
			attack_in_progress = true
			if arah == "kanan":
				$AnimatedSprite2D.play("serang_kanan")
				$deal_attack_timer.start()
				$player_hitbox_kanan.toggle_collision(true)
			if arah == "kiri":
				$AnimatedSprite2D.flip_h = true
				$AnimatedSprite2D.play("serang_kanan")
				$deal_attack_timer.start()
				$player_hitbox_kiri.toggle_collision(true)
			if arah == "bawah":
				$AnimatedSprite2D.play("serang_bawah")
				$deal_attack_timer.start()
				$player_hitbox_bawah.toggle_collision(true)
			if arah == "atas":
				$AnimatedSprite2D.play("serang_atas")
				$deal_attack_timer.start()
				$player_hitbox_atas.toggle_collision(true)
			GlobalScript.isi_air_gayung -=1
			print(GlobalScript.isi_air_gayung)
		GlobalScript.pencet = false

func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	GlobalScript.player_current_attack = false
	attack_in_progress = false
	$AnimatedSprite2D.flip_h = false
	$player_hitbox_kiri.toggle_collision(false)
	$player_hitbox_kanan.toggle_collision(false)
	$player_hitbox_bawah.toggle_collision(false)
	$player_hitbox_atas.toggle_collision(false)

func collect(item):
	inv.insert(item)
