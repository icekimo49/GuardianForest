extends Node

const MAX_RANGE = 100
@export var lemparBotol : PackedScene


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Timer.timeout.connect(on_timer_timeout)
	
	
func on_timer_timeout():
	if(GlobalScript.tombol_serang == true):
		var player = get_tree().get_first_node_in_group("player") as Node2D
		if 	player == null:	
			return
			
			
		#### Penebang
		var enemies = get_tree().get_nodes_in_group("enemy")
		
		enemies = enemies.filter(func(enemy : Node2D):
			return enemy.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE,2)
		)
		
		if enemies.size() == 0:
			return
			
		enemies.sort_custom(func(a:Node2D, b:Node2D):
			var a_distance = a.global_position.distance_squared_to(player.global_position)
			var b_distance = b.global_position.distance_squared_to(player.global_position)
			return a_distance < b_distance	
		)
		
		var lemparBotol_instance = lemparBotol.instantiate() as Node2D
		player.get_parent().add_child(lemparBotol_instance)
		lemparBotol_instance.global_position = enemies[0].global_position
		
		GlobalScript.tombol_serang = false
	#lemparBotol_instance.global_position += Vector2.RIGHT.rotated(randf_range(0,TAU)) *4
	#
	#var arah_enemy = enemies[0].global_position - lemparBotol_instance.global_position
	#lemparBotol_instance.rotation = arah_enemy.angle()
	
	
	###########    API
	#var api = get_tree().get_nodes_in_group("enemy")
	#
	#api = api.filter(func(fire : Node2D):
		#return fire.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE,2)
	#)
	#
	#if api.size() == 0:
		#return
		#
	#api.sort_custom(func(x:Node2D, y:Node2D):
		#var x_distance = x.global_position.distance_squared_to(player.global_position)
		#var y_distance = y.global_position.distance_squared_to(player.global_position)
		#return x_distance < y_distance	
	#)
	#
	#var lemparBotol_instance2 = lemparBotol.instantiate() as Node2D
	#player.get_parent().add_child(lemparBotol_instance2)
	#lemparBotol_instance2.global_position = api[0].global_position
