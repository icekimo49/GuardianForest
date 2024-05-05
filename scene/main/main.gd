extends Node2D
var boleh_spawn = true

var penebang_kayu = preload("res://scene/penebang/Penebang_kayu.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_spawner_penebang_kayu_timeout():
	if boleh_spawn:
		var musuh = penebang_kayu.instantiate()
		add_child(musuh)
		musuh.position = $Spawner_PenebangKayu.position

func _on_timer_level_timeout():
	boleh_spawn = false
	print("waktu habis")
