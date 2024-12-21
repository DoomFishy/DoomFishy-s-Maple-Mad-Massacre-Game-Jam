extends State

@export var idle_state : State
@export var move_up_state : State
@export var move_left_state : State
@export var move_right_state : State

@export var dash_state: State

@export var attack_down_state: State
@export var attack_side_state: State
@export var attack_up_state: State

@export var shoot_state: State
@export var summon_state: State
@export var laser_state: State

@export var MAX_SPEED = 600
@export var ACCEL = 1500
@export var FRICTION = 6500

func enter() -> void:
	super()

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("ability_1"):
		if Global.has_exchange_vacuum:
			return shoot_state
		if Global.has_exchange_squirrel:
			return laser_state
		if Global.has_exchange_bobby:
			return summon_state
		
	var mouse_direction = (parent.get_global_mouse_position() - parent.global_position).normalized()

	if Input.is_action_just_pressed("attack"):
		var angle : float = atan2(mouse_direction.y, mouse_direction.x)
		if abs(angle) < PI/4:
			#print("right")
			if parent.get_node("weapon/hurtbox_side_area/hurtbox_side").position.x < 0:
				parent.get_node("weapon/hurtbox_side_area/hurtbox_side").position.x *= -1
			return attack_side_state
		elif angle < -PI/4 and angle > -3*PI/4:
			#print("up")
			return attack_up_state
		elif angle < 3*PI/4 and angle > PI/4:
			#print("down")
			return attack_down_state
		else:
			#print("left")
			if parent.get_node("weapon/hurtbox_side_area/hurtbox_side").position.x > 0:
				parent.get_node("weapon/hurtbox_side_area/hurtbox_side").position.x *= -1
			return attack_side_state
			
	if Input.is_action_just_pressed('dash'):
		return dash_state
		
	return null

func process_physics(delta: float) -> State:
	if get_movement_input() == Vector2.ZERO:
		if parent.velocity.length() > (FRICTION * delta):
			parent.velocity -= parent.velocity.normalized() * (FRICTION * delta)
		else:
			parent.velocity = Vector2.ZERO
			return idle_state

	else:
		parent.velocity += (get_movement_input() * delta * ACCEL)
		parent.velocity = parent.velocity.limit_length(MAX_SPEED)
		
		if get_movement_input() == Vector2(1,0):
			return move_right_state
		if get_movement_input() == Vector2(-1,0):
			return move_left_state
		if get_movement_input() == Vector2(0,-1):
			return move_up_state
									
	parent.move_and_slide()
	
	return null
