extends State

@export var move_state: State
@export var stomp_state: State
@export var barrage_state: State
@export var laser_state_1: State
@export var laser_state_2: State

var is_dead = false
var can_move = false
var can_attack = false

func enter() -> void:
	super()
	await get_tree().create_timer(3).timeout
	
	if Global.is_half_hp:
		$attack_intervals.wait_time = 0.5
	else:
		$attack_intervals.wait_time = 1
	can_attack = false
	parent.velocity = Vector2.ZERO
	
	$attack_intervals.start()
	var direction = Global.player_pos - parent.global_position
	var angle = atan2(direction.y, direction.x)
	
	if abs(angle) < PI/4:
		parent.get_node("AnimatedSprite2D").flip_h = false
	else:
		parent.get_node("AnimatedSprite2D").flip_h = true
		
func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	var rng = RandomNumberGenerator.new()
	
	var rand_can_attack = rng.randi_range(1, 3)
	var rand_attack_state = rng.randi_range(1,2)
	var rand_can_move = rng.randi_range(1, 25)
	
	if not is_dead:
		if can_move:
			if rand_can_move == 1:
				return move_state
		
		if can_attack:
			if not Global.is_half_hp and rand_can_attack < 3:
				return laser_state_1
				
			if rand_can_attack == 3:
				return barrage_state

			if Global.is_half_hp:
				if rand_can_attack < 3:
					return laser_state_2
	return null

func is_dead_():
	is_dead = true

func _on_attack_intervals_timeout():
	can_attack = true

func _on_too_close_move_area_entered(area):
	if area is PlayerHitboxComponent:
		can_move = true

func _on_too_close_move_area_exited(area):
	if area is PlayerHitboxComponent:
		can_move = false
