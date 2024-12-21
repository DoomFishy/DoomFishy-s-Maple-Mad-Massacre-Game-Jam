extends State
class_name attack_state

@export var move_state: State
@export var idle_state: State
@export var attack_2_front_state: State
@export var attack_2_back_state: State
@export var attack_2_side_state: State
@export var dash_state: State

@export var time_to_attack := 0.5

@export var ATTACK_MAX_SPEED = 250.0
@export var ACCEL = 6400
@export var FRICTION = 12800

var dont_move

var direction: Vector2
var mouse_direction: Vector2
var want_to_attack_2 = false
var no_attack_2 = false
var attack_timer := 0.0

func enter() -> void:
	super()
	parent.get_node("weapon/hurtbox_side_area/hurtbox_side").disabled = true
	parent.get_node("weapon/hurtbox_up_area/hurtbox_up").disabled = true
	parent.get_node("weapon/hurtbox_down_area/hurtbox_down").disabled = true
	parent.velocity = Vector2.ZERO
	
	mouse_direction = (parent.get_global_mouse_position() - parent.global_position).normalized()
	
	if mouse_direction.x < 0:
		parent.get_node("AnimatedSprite2D").flip_h = false
		parent.get_node("vacuum_appearance").flip_h = false
	else:
		parent.get_node("AnimatedSprite2D").flip_h = true
		parent.get_node("vacuum_appearance").flip_h = true
	attack_timer = time_to_attack
	want_to_attack_2 = false
	
	if parent.get_node("AnimatedSprite2D").flip_h == true:
		direction = Vector2(1,0)
	else:
		direction = Vector2(-1,0)

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("dash"):
		return dash_state
		
	if Input.is_action_just_pressed("attack") and not no_attack_2:
		want_to_attack_2 = true
	return null

func process_physics(delta: float) -> State:
	attack_timer -= delta
	
	if attack_timer > 0.0 and attack_timer <= 0.2:
		if parent.velocity.length() > (FRICTION * delta):
			parent.velocity -= parent.velocity.normalized() * (FRICTION * delta)
			
	elif attack_timer <= 0.0:
		parent.velocity = Vector2.ZERO
		
		if want_to_attack_2:
			mouse_direction = (parent.get_global_mouse_position() - parent.global_position).normalized()
			var angle : float = atan2(mouse_direction.y, mouse_direction.x)
					
			if abs(angle) < PI/4:
				#print("right2")
				if parent.get_node("weapon/hurtbox_side_area/hurtbox_side").position.x < 0:
					parent.get_node("weapon/hurtbox_side_area/hurtbox_side").position.x *= -1
				return attack_2_side_state
			elif angle < -PI/4 and angle > -3*PI/4:
				return attack_2_back_state
			elif angle < 3*PI/4 and angle > PI/4:
				return attack_2_front_state
			else:
				#print("left2")
				if parent.get_node("weapon/hurtbox_side_area/hurtbox_side").position.x > 0:
					parent.get_node("weapon/hurtbox_side_area/hurtbox_side").position.x *= -1				
				return attack_2_side_state
			
		if super.get_movement_input() != Vector2.ZERO:
			return move_state
		return idle_state
		
	elif attack_timer <= 0.4:
		move_attack(delta)
		
	parent.move_and_slide()
	return null
	
func finish():
	no_attack_2 = true
	return idle_state
	
func move_attack(delta):
	if not dont_move:
		parent.velocity = mouse_direction * ATTACK_MAX_SPEED
