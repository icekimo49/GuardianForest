extends Node2D

const SPEED = 25
@onready var animation_player = $AnimationPlayer
@onready var sprite_alang = $SpriteAlang
@onready var kanan = $kanan
@onready var kiri = $kiri
@onready var rotasi_default = rotation_degrees

var KECEPATAN_GERAK = get_physics_process_delta_time() * 40
const ROTASI = 70

var state_kiri = false
var state_kanan = false
var have_collision = false
var animasi_speed 

func animasi_ke_kiri():
	animation_player.play("ke_kiri")
	
func animasi_ke_kanan():
	animation_player.play("ke_kanan")

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("idle")
	animasi_speed = randf_range(0.1,1)
	animation_player.speed_scale = animasi_speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass

func _on_kanan_body_entered(body):
	if body.is_in_group("player"):
		#animation_player.play("RESET")
		#animation_player.stop()
		animation_player.speed_scale = 1
		animasi_ke_kanan()
		state_kiri = true

func _on_kiri_body_entered(body):
	if body.is_in_group("player"):
		#animation_player.play("RESET")
		#animation_player.stop()
		animation_player.speed_scale = 1
		animasi_ke_kiri()
		state_kanan = true
		
		

#func _on_kiri_body_exited(body):
	#deteksi_orang_keluar(body)
	#state_kiri = false
	
func deteksi_orang_keluar(body):
	if body.is_in_group("player"):
		#animation_player.play("idle")
		rotation_degrees = rotasi_default
		have_collision = false
		print("KELUAR")

#func _on_kanan_body_exited(body):
	#deteksi_orang_keluar(body)
	#state_kanan = false
	#

func dari_kiri():
	if state_kiri && !have_collision:
		rotation_degrees = 70
		#have_collision = true
		print(rotation_degrees)
		
func dari_kanan():
	if state_kanan && !have_collision:
		rotation_degrees = 70
		#have_collision = true
		print(rotation_degrees)
