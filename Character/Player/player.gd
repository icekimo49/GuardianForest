extends CharacterBody2D

var save_file_path = "res://Save_file/"
var save_file_name = "PlayerSave.tres"
var playerData = PlayerData.new()
var data_awal = PlayerData.new()

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
var layout
@onready var barDarah = $barDarah
@onready var textDamage = $damage_diterima
@onready var textAir = $airIndikator
@onready var nav = $NavigationAgent2D

var pohon_kecil = preload("res://Areas/Hutan/Environment/Pohon/pohon_baru_tanam/pohon_kecil.tscn")


func _ready():
	load_data()
	display_darah_player()
	verify_save_directory(save_file_path)

func verify_save_directory(path: String):
	DirAccess.make_dir_absolute(path)

func load_data():
	playerData = ResourceLoader.load(save_file_path + save_file_name).duplicate(true)
	GlobalScript.tingkat_wave = playerData.wave
	GlobalScript.time = playerData.time
	GlobalScript.sudah_tutorial = playerData.sudah_tutorial
	GlobalScript.inv = playerData.inv
	GlobalScript.exp = playerData.exp
	print("loaded")

func save():
	playerData.time = GlobalScript.time 
	playerData.sudah_tutorial = GlobalScript.sudah_tutorial
	playerData.wave = GlobalScript.tingkat_wave
	playerData.inv = GlobalScript.inv
	playerData.exp = GlobalScript.exp
	ResourceSaver.save(playerData, save_file_path + save_file_name)
	print("save")

func new_game(): 
	data_awal.inv = preload("res://global_script/global_script_temp_inv.tres")
	data_awal.sudah_tutorial = false
	ResourceSaver.save(data_awal, save_file_path + save_file_name)
	print(data_awal.sudah_tutorial)

func change_wave():
	playerData.change_wave(1)
	GlobalScript.tingkat_wave = playerData.wave

func change_exp(value: int):
	playerData.change_exp(value)

func save_time():
	playerData.save_time()

func notif_air_habis():
	DamageToPlayer.display_air("Air Habis!", textDamage.global_position)

func display_darah_player(): #Buat nampilin sisa darah player
	barDarah.value = playerData.hp

func display_air_indikator(): #Buat nampilin jumlah sisa air
	textAir.text = str(GlobalScript.isi_air_gayung) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("save"):
		save_time()
		save()
	if Input.is_action_just_pressed("load"):
		load_data()
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
	if playerData.hp <= 0:
		player_alive = false #pindah ke main menu
		playerData.hp = 0
		self.queue_free()
		
func get_movement_vector():
	var inputX = Input.get_action_strength("ui_kanan")-Input.get_action_strength("ui_kiri")
	var inputY = Input.get_action_strength("ui_bawah")-Input.get_action_strength("ui_atas")
	return Vector2(inputX, inputY)

func player():
	pass
	#jangan diapus, penting!!!!

func api_attack():
	if api_inattack_range and api_attack_cooldown == true:
		playerData.change_hp(-kerusakan)
		display_darah_player() #Update Value Bar Darah
		DamageToPlayer.display_damage(kerusakan, textDamage.global_position) #Nampilin Damage
		api_attack_cooldown = false
		$api_cooldown.start()
		print(playerData.hp)

func _on_api_cooldown_timeout():
	api_attack_cooldown = true

func attack():
	var arah = animasi_player
	if GlobalScript.inv_is_open == false:
		if GlobalScript.item_in_use == "ember":
			attack_ember()
		elif GlobalScript.item_in_use == "biji":
			tanam_pohon()
	await get_tree().create_timer(2.0).timeout
	GlobalScript.pencet = false

func attack_ember():
	var arah = animasi_player
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

func tanam_pohon():
	if GlobalScript.pencet:
		if GlobalScript.boleh_tanam:
			var instance = pohon_kecil.instantiate()
			instance.global_position = self.global_position
			var parent_node = get_parent().get_node("NavigationRegion2D")
			parent_node.add_child(instance)
			playerData.inv.decrease("biji")

func _on_deal_attack_timer_timeout():
	print("aselole")
	$deal_attack_timer.stop()
	GlobalScript.player_current_attack = false
	attack_in_progress = false
	if attack_in_progress == false:
		print("gagal")
	$AnimatedSprite2D.flip_h = false
	$player_hitbox_kiri.toggle_collision(false)
	$player_hitbox_kanan.toggle_collision(false)
	$player_hitbox_bawah.toggle_collision(false)
	$player_hitbox_atas.toggle_collision(false)

func collect(item):
	playerData.inv.insert(item)

func _on_player_hitbox_area_entered(area):
	if area.name == "api_hitbox":
		api_inattack_range = true

func _on_player_hitbox_area_exited(area):
	if area.name == "api_hitbox":
		api_inattack_range = false

func gerakan_tutorial(tujuan, arah):
	velocity = global_position.direction_to(tujuan) * 150
	animasi_player = arah
	animasi(1)
	move_and_slide()

func posisi_tutorial(arah):
	animasi_player = arah
	animasi(0)

func dialog_player_sendiri(lokasi):
	if lokasi == "mainmenu":
		#disesuaikan sama jumlah dialog yang ada
		var opsi = randi_range(1,1)
		layout = Dialogic.start("mainmenu_" + str(opsi))
	elif lokasi == "gametutorial":
		#disesuaikan sama jumlah dialog yang ada
		var opsi = randi_range(1,1)
		layout = Dialogic.start("gametutorial_" + str(opsi))
	layout.register_character(load("res://Dialogic/Player/Player.dch"), $".")
	await get_tree().create_timer(2).timeout
	Dialogic.Inputs.auto_skip.enabled = !Dialogic.Inputs.auto_skip.enabled

func _on_player_hitbox_body_entered(body):
	pass

func gerak_path_finding(target):
	if nav.is_navigation_finished() == false:
		var next_target = nav.get_next_path_position()
		velocity = global_position.direction_to(target) * kecepatan
		move_and_slide()
