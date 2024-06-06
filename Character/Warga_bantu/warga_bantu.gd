extends CharacterBody2D

@onready var navAgent = $NavigationAgent2D
var posisi_tujuan_awal:Vector2
var nama_musuh
var speed = 150
var musuh_terlihat = false
var lokasi_musuh

func _ready():
	tujuan_awal()
	$Area2D/CollisionShape2D.disabled = true

func _process(delta):
	set_next_target()
	if self.global_position.distance_to(posisi_tujuan_awal) < 2:
		$Area2D/CollisionShape2D.disabled = false
	if musuh_terlihat:
		lokasi_musuh = get_parent().get_node("../musuh/" + nama_musuh)
		lokasi_musuh = lokasi_musuh.get_position()
		tujuan_selanjutnya()

func tujuan_awal():
	navAgent.target_position = posisi_tujuan_awal

func tujuan_selanjutnya():
	navAgent.target_position = lokasi_musuh

func set_next_target():
	if navAgent.is_navigation_finished() == false:
		var next_target = navAgent.get_next_path_position()
		#if navAgent.is_target_reachable() == false:
			#tujuan()
			#return
		velocity = global_position.direction_to(next_target) * speed
		move_and_slide()



func _on_area_2d_body_entered(body):
	if body.name == nama_musuh:
		musuh_terlihat = true
