extends CharacterBody2D

const kecepatan : int = 250
const akselerasi  = 25
var hp = 100
var api_inattack_range = false
var api_attack_cooldown = true
var player_alive = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var arah = get_movement_vector()
	var arahNormalized = arah.normalized()
	velocity = arahNormalized * kecepatan
	#var target_velocity = arahNormalized  *kecepatan
	#velocity = velocity.lerp(target_velocity, 1 - exp(-delta * akselerasi))
	move_and_slide()
	
	#Controller 
	velocity = $"../UI/joystick".get_velo().normalized() * kecepatan
	move_and_slide()
	
	pass

func _physics_process(delta):
	api_attack()
	
	
	if hp <= 0:
		player_alive = false #pindah ke main menu
		hp = 0
		self.queue_free()
		
func get_movement_vector():
	var inputX = Input.get_action_strength("ui_kanan")-Input.get_action_strength("ui_kiri")
	var inputY = Input.get_action_strength("ui_bawah")-Input.get_action_strength("ui_atas")
	return Vector2(inputX, inputY)



func _on_player_hitbox_body_entered(body):
	if body.has_method("api"):
		api_inattack_range = true
		api_attack()

func _on_player_hitbox_body_exited(body):
	if body.has_method("api"):
		api_inattack_range = false

func api_attack():
	if api_inattack_range and api_attack_cooldown == true:
		hp -= 20
		api_attack_cooldown = false
		$api_cooldown.start()
		print(hp)

func _on_api_cooldown_timeout():
	api_attack_cooldown = true
