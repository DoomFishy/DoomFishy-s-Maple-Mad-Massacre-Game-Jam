extends State

@export var chase_side_state: State
@export var chase_front_state: State
@export var chase_back_state: State

@export var attack_front_state: State
@export var attack_side_state: State
@export var attack_back_state: State

@export var speed := 50
@export var accel := 1000

var can_attack
var can_walk = false
var return_to_attack
var enemy_direction = Vector2.ZERO
var rng = RandomNumberGenerator.new()

func enter() -> void:
	super()
	var direction = enemy_direction - parent.global_position
	var angle = atan2(direction.y, direction.x)
	
	
	if abs(angle) < PI/4:
		parent.get_node("AnimatedSprite2D").flip_h = true
		if parent.get_node("weapon/hurtbox_side/CollisionShape2D").position.x > 0:
			parent.get_node("weapon/hurtbox_side/CollisionShape2D").position.x *= -1
	else:
		parent.get_node("AnimatedSprite2D").flip_h = false
		if parent.get_node("weapon/hurtbox_side/CollisionShape2D").position.x < 0:
			parent.get_node("weapon/hurtbox_side/CollisionShape2D").position.x *= -1

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	var rand = rng.randi_range(1,50)
	
	if return_to_attack and rand == 1:
		return_to_attack = false
		var direction = enemy_direction - parent.global_position
		var angle = atan2(direction.y, direction.x)
		
		if abs(angle) < PI/4:
			return attack_side_state
		elif angle < -PI/4 and angle > -3*PI/4:
			return attack_back_state
		elif angle < 3*PI/4 and angle > PI/4:
			return attack_front_state
		else:
			return attack_side_state

	else:
		walk(delta)
		var direction = enemy_direction - parent.global_position
		var angle = atan2(direction.y, direction.x)
		
		if abs(angle) < PI/4:
			return chase_side_state
		elif angle < -PI/4 and angle > -3*PI/4:
			return chase_back_state
		elif angle < 3*PI/4 and angle > PI/4:
			return chase_front_state
		else:
			return chase_side_state
	return null

func walk(delta):
	var direction = enemy_direction - parent.global_position
	var angle = atan2(direction.y, direction.x)
	parent.velocity = (direction.normalized() * speed)
	parent.velocity = parent.velocity.limit_length(speed)
	parent.move_and_slide()

func _on_timer_timeout():
	can_walk = true

func _on_attack_detect_player_area_entered(area):
	if area is HitboxComponent:
		return_to_attack = true

func _on_attack_intervals_timeout():
	can_attack = true

func _on_attack_detect_player_body_entered(body):
	if body.name == "player":
		return_to_attack = true

func _on_chase_detect_player_area_entered(area):
	if area is HitboxComponent:
		enemy_direction = area.global_position

func _on_chase_detect_player_body_entered(body):
	if body.is_in_group("boss"):
		enemy_direction = body.global_position
