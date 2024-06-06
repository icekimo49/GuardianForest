extends CharacterBody2D

var target_node = null
var speed = 200
var kabur = false
var player = null
var kabur_gak_nich = false
@onready var navAgent = $Navigasi/NavigationAgent2D
var items = ["res://Item/Material/biji/biji.tscn", "res://Item/Material/Batu/batu_collectable.tscn", "res://Item/Material/Golden_Apple/golden_apple_collectable.tscn"]
var i = 0
func _ready():
	set_physics_process(false)
	tujuan()
	call_deferred("set_physics_process", true)
	pass

func _physics_process(delta):
	set_next_target()
	if kabur_gak_nich == true:
		jadi_kabur_gak_nich()
	if kabur :
		navAgent.target_position = (Vector2(2000,2000) - position).normalized()
	if GlobalScript.drop_item == true:
		drop_item()

func tujuan():
	navAgent.target_position = GlobalScript.posisi_pohon[randi_range(0, GlobalScript.posisi_pohon.size()-1)]

func set_next_target():
	if navAgent.is_navigation_finished() == false:
		var next_target = navAgent.get_next_path_position()
		if navAgent.is_target_reachable() == false and kabur == false:
			tujuan()
			return
		velocity = global_position.direction_to(next_target) * speed
		move_and_slide()

func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		kabur_gak_nich = true
		player = body

func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		kabur_gak_nich = false

func _on_timer_timeout():
	queue_free()

func _on_lingkar_jauh_area_entered(area):
	target_node = area.owner

func _on_lingkar_dekat_area_entered(area):
	if (area.owner == target_node):
		target_node = null

func penebang_kayu():
	pass

func drop_item():
	if i == 0:
		var drop = items[randi_range(0, items.size()-1)]
		drop = load(drop)
		var item_instance = drop.instantiate()
		item_instance.position = GlobalScript.drop_item_loc
		item_instance.position.x += 30
		get_parent().add_child(item_instance)
		GlobalScript.drop_item = false
		i+=1

func jadi_kabur_gak_nich():
	if GlobalScript.item_in_use == "kentongan" and GlobalScript.pencet == true:
		kabur = true
		$Timer.start()
		GlobalScript.drop_item_loc = self.position
		GlobalScript.drop_item = true
