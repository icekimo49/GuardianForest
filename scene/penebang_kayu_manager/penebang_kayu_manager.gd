extends Node2D

const Spawn_Radius  = 375

@export var penebang_kayu_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.timeout.connect(on_timer_timeout)
	
	
func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null :
		return
	var random_direction = Vector2.RIGHT.rotated(randf_range(0,TAU))
	var random_position = player.global_position + (random_direction * Spawn_Radius)
	var enemy = penebang_kayu_scene.instantiate() as Node2D
	get_parent().add_child(enemy)
	enemy.global_position = random_position 
	

