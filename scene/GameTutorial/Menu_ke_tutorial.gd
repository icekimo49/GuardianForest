extends Node2D

var state_start = false
@onready var joystick = $UI/joystick
@onready var canvas_layer = $CanvasLayer
@onready var main_text = $CanvasLayer/RichTextLabel
@onready var guardian_forest = $CanvasLayer/guardian_forest
@onready var gemastik = $CanvasLayer/Gemastik
@onready var cahaya_GF = $CanvasLayer/guardian_forest/PointLight2D
@onready var camera = $Camera2D
@onready var analog_tutorial = $CanvasLayer/analog_tutorial

#Animasi Latar
@onready var latar = $ParallaxBackground3/Latar
@onready var bulan = $ParallaxBackground3/bulan_bintang_layer
@onready var klise_bulan = $ParallaxBackground3/klise_bulan
@onready var awan_2 = $ParallaxBackground3/awan2
@onready var player = $Player

var awan_sudah_naik = false

#Warna
var warna_kosong = Color(0,0)
@onready var warnaGF = guardian_forest.modulate
@onready var warna_default_joystick = joystick.modulate
@onready var warna_analog_tutorial = analog_tutorial.modulate

# Called when the node enters the scene tree for the first time.
func _ready():
	cahaya_GF.energy = 0
	joystick.enable_analog = false
	joystick.modulate = Color(0,0)
	guardian_forest.modulate = warna_kosong
	gemastik.modulate = warna_kosong
	analog_tutorial.modulate = warna_kosong
	player.barDarah.visible = false
	player.textAir.visible = false
	
	player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	bulan.global_position.x -= 1 * delta
	if !awan_sudah_naik:
		awan_2.global_position.x -= 3 * delta
	if !state_start :
		return
	animasi()
	
	
func _on_tombol_start_pressed():
	state_start = true
	
func animasi():
	var delta = get_physics_process_delta_time()
	main_text.modulate = lerp(main_text.modulate,Color(0,0),10* delta)
	await get_tree().create_timer(1.0).timeout
	
	cahaya_GF.energy = lerp(cahaya_GF.energy, 1.5, 2 *delta)
	guardian_forest.modulate = lerp(guardian_forest.modulate,warnaGF,2* delta)
	await get_tree().create_timer(2.0).timeout
	guardian_forest.modulate = lerp(guardian_forest.modulate,Color(0,-2),2* delta)
	await get_tree().create_timer(1.0).timeout
	
	gemastik.modulate = lerp(gemastik.modulate,warnaGF,2* delta)
	await get_tree().create_timer(2.0).timeout
	gemastik.modulate = lerp(gemastik.modulate,Color(0,-2),2* delta)
	cahaya_GF.energy = lerp(cahaya_GF.energy, 0.0, 2 *delta)
	
	await get_tree().create_timer(2.0).timeout
	awan_sudah_naik = true
	awan_2.global_position.y = lerp(awan_2.global_position.y, 70.0, lerp(3,0,1*delta) * delta)
	camera.global_position = lerp(camera.global_position,Vector2(camera.global_position.x, 213.0),2 * delta)
	
	await get_tree().create_timer(1).timeout
	joystick.modulate = lerp(joystick.modulate, warna_default_joystick, 3 * delta)
	await get_tree().create_timer(.5).timeout
	analog_tutorial.modulate = lerp(analog_tutorial.modulate, warna_default_joystick, 3 * delta)
	state_start = true
	joystick.enable_analog = true
	await get_tree().create_timer(2).timeout
	$CanvasLayer/analog_tutorial/tutorial_ngedip.play("ngedip")

