extends CharacterBody2D

var target_node = null
var speed = 200
var kabur = false
var player = null
@export var batu = preload("res://Item/Material/Batu/batu_collectable.tscn")
@onready var navAgent = $Navigasi/NavigationAgent2D


func _ready():
	set_physics_process(false)
	tujuan()
	call_deferred("set_physics_process", true)
	pass

func _physics_process(delta):
	tujuan()
	set_next_target()
	if kabur :
		var direction = (Vector2(2000,2000) - position).normalized()
		position += direction * speed * delta
	if GlobalScript.drop_item == true:
		drop_item()

func tujuan():
	print(GlobalScript.posisi_pohon[randi_range(0, GlobalScript.posisi_pohon.size()-1)])
	navAgent.target_position = Vector2(260.0, 48.0)

func set_next_target():
	if navAgent.is_navigation_finished() == false:
		var next_target = navAgent.get_next_path_position()
		if navAgent.is_target_reachable() == false :
			tujuan()
			print("gabisa")
			return
		print("bisa")
		velocity = global_position.direction_to(next_target) * speed
		move_and_slide()

func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		player = body
		kabur = true
		$Timer.start()
		GlobalScript.drop_item_loc = self.position
		GlobalScript.drop_item = true

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
	var item_instance = batu.instantiate()
	item_instance.position = GlobalScript.drop_item_loc
	item_instance.position.x += 30
	get_parent().add_child(item_instance)
	GlobalScript.drop_item = false
