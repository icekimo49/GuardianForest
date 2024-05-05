extends Camera2D

var target_position = Vector2(0,0)
var kondisi_inventory = false
# Called when the node enters the scene tree for the first time.
func _ready():
	GameEvent.connect("kamera_ke_inventory", Callable(self, "_kamera_ke_inventory"))
	make_current()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_camera()
	global_position = global_position.lerp(target_position, 1.0 - exp(-delta *25))

func _physics_process(delta):
	camera_slider()	

func get_camera():
	var player_nodes = get_tree().get_nodes_in_group("player")
	if (player_nodes.size() > 0):
		var player = player_nodes[0] as Node2D
		target_position = player.global_position
func _kamera_ke_inventory(kondisi):
	kondisi_inventory = kondisi

func camera_slider():
	if kondisi_inventory:
		offset.y = lerp(offset.y,-100.0, get_physics_process_delta_time() * 9)
	else :
		offset.y = lerp(offset.y,0.0, get_physics_process_delta_time() * 9)
