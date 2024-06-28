extends Node2D

var next_level = false
var state_start = false
var next_target

@onready var awan_2 = $ParallaxBackground3/awan2
@onready var awan_3 = $ParallaxBackground3/awan3


#Tombol Start
@onready var tombol_start = $CanvasLayer/tombol_start
@onready var tombol_setting = $CanvasLayer/tombol_setting



@onready var canvas_layer = $CanvasLayer
@onready var main_text = $CanvasLayer/RichTextLabel
@onready var guardian_forest = $guardian_forest
@onready var gemastik = $CanvasLayer/Gemastik
@onready var cahaya_GF = $CanvasLayer/PointLight2D
@onready var camera = $Camera2D
@onready var analog_tutorial = $CanvasLayer/analog_tutorial
@onready var unnes = $CanvasLayer/UNNES
@onready var lucky_semua = $CanvasLayer/LuckySemua

#Animasi Latar
@onready var latar = $ParallaxBackground3/Latar
@onready var bulan = $ParallaxBackground3/bulan_bintang_layer
@onready var klise_bulan = $ParallaxBackground3/klise_bulan
@onready var player = $Player

var awan_sudah_naik = false

#Warna
var warna_kosong = Color(0,0)
@onready var warnaGF = guardian_forest.modulate
@onready var warna_default_joystick = Color(1, 1, 1, 1)
@onready var warna_analog_tutorial = analog_tutorial.modulate
@onready var pengaturan = $pengaturan/Pengaturan
@onready var tombol = $CanvasLayer/Tombol
# Called when the node enters the scene tree for the first time.
func _ready():
	cahaya_GF.energy = 0
	guardian_forest.modulate = warna_kosong
	gemastik.modulate = warna_kosong
	analog_tutorial.modulate = warna_kosong
	player.barDarah.visible = false
	player.textAir.visible = false
	unnes.modulate = warna_kosong
	lucky_semua.modulate = warna_kosong
	player
	pengaturan.visible = false
	tombol.visible = false
	tombol_setting_mati()
	GlobalScript.scene_sebelum_loading = get_tree().current_scene.get_name()

func tombol_setting_mati():
	tombol_setting.modulate = warna_kosong
	tombol_setting.set_block_signals(true)

func tombol_setting_nyala():
	tombol_setting.set_block_signals(false)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	bulan.global_position.x -= 1 * delta
	if !awan_sudah_naik:
		awan_3.global_position.x -= 3* delta
		awan_2.global_position.x -=3 * delta
	if !state_start :
		return
	if !next_level :
		animasi()
	if next_target != null:
		$Player.gerakan_tutorial(next_target, "kanan")
	
func _on_tombol_start_pressed():
	state_start = true
	
func animasi():
	if !get_tree():
		print("a")
		return
	var delta = get_physics_process_delta_time()
	main_text.modulate = lerp(main_text.modulate,Color(0,0),10* delta)
	await get_tree().create_timer(1.0).timeout
	lucky_semua.modulate = lerp(lucky_semua.modulate,warnaGF,2* delta)
	await get_tree().create_timer(2.0).timeout
	lucky_semua.modulate = lerp(lucky_semua.modulate,Color(0,-2),2* delta)
	await get_tree().create_timer(2.0).timeout
	
	cahaya_GF.energy = lerp(cahaya_GF.energy, 1.5, 2 *delta)
	gemastik.modulate = lerp(gemastik.modulate,warnaGF,2* delta)
	unnes.modulate = lerp(unnes.modulate, warnaGF, 2*delta)
	await get_tree().create_timer(2.0).timeout
	gemastik.modulate = lerp(gemastik.modulate,Color(0,-2),2* delta)
	unnes.modulate = lerp(unnes.modulate, Color(0,-2), 2*delta)
	cahaya_GF.energy = lerp(cahaya_GF.energy, 0.0, 2 *delta)
	
	await get_tree().create_timer(2.0).timeout
	guardian_forest.modulate = lerp(guardian_forest.modulate,warnaGF,2* delta)
	await get_tree().create_timer(2.0).timeout
	#guardian_forest.modulate = lerp(guardian_forest.modulate,Color(0,-2),2* delta)
	
	
	
	await get_tree().create_timer(2.0).timeout
	awan_sudah_naik = true
	guardian_forest.global_position.y = lerp(guardian_forest.global_position.y, 30.0,lerp(3,0,1*delta) * delta)
	awan_2.global_position.y = lerp(awan_2.global_position.y, 30.0, lerp(3,0,1*delta) * delta)
	camera.global_position = lerp(camera.global_position,Vector2(camera.global_position.x, 213.0),2 * delta)
	
	await get_tree().create_timer(1).timeout
	tombol_setting.modulate = lerp(tombol_setting.modulate, warna_default_joystick,3 * delta)
	tombol_setting_nyala()
	#joystick.modulate = lerp(joystick.modulate, warna_default_joystick, 3 * delta)
	#await get_tree().create_timer(.5).timeout
	#analog_tutorial.modulate = lerp(analog_tutorial.modulate, warna_default_joystick, 3 * delta)
	state_start = true
	tombol.visible = true
	#joystick.enable_analog = true
	#await get_tree().create_timer(2).timeout
	#$CanvasLayer/analog_tutorial/tutorial_ngedip.play("ngedip")

func _on_border_next_stage_body_entered(body):
	if body.is_in_group("player"):
		var LOADING_SCREEN_PATH = load("res://scene/loading_screen/loading_screen.tscn")
		analog_tutorial.modulate = warna_kosong
		next_level = true
		get_tree().change_scene_to_packed(LOADING_SCREEN_PATH)

func _on_visible_on_screen_notifier_2d_screen_exited():
	awan_2.global_position.x = 250
	
func _on_awan_3_screen_exit_screen_exited():
	awan_3.global_position.x = 250
	
func diam_ditempat():
	pass
	
func _on_tombol_setting_pressed():
	pengaturan.visible = true
	canvas_layer.hide()

func tampil_setelah_pengaturan():
	canvas_layer.visible = true

func _on_mulai_pressed():
	$CanvasLayer/Tombol/GridContainer/Mulai.disabled = true
	await $Player.new_game()
	#mulai dialog
	$Player.dialog_player_sendiri("mainmenu")
	await get_tree().create_timer(2.0).timeout
	next_target = Vector2(-472, 229)

func _on_lanjutkan_pressed():
	$CanvasLayer/Tombol/GridContainer/Lanjutkan.disabled = true
	$Player.dialog_player_sendiri("mainmenu")
	await get_tree().create_timer(2.0).timeout
	next_target = Vector2(-472, 229)

