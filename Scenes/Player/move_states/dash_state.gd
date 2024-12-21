extends State

@export var idle_state : State
@export var move_state: State

@export var DASH_MAX_SPEED = 2000.0
@export var ACCEL = 18000
@export var FRICTION = 32000

@export var time_to_dash := 0.3

var dash_timer := 0.0

var dir
var direction: Vector2

func enter() -> void:
	super()
	parent.get_node("weapon/hurtbox_side_area/hurtbox_side").disabled = true
	parent.get_node("weapon/hurtbox_up_area/hurtbox_up").disabled = true
	parent.get_node("weapon/hurtbox_down_area/hurtbox_down").disabled = true
	
	direction = move_component.get_movement_direction()
	dash_timer = time_to_dash
	direction_facing_animation()
	
	if direction.x > 0:
		parent.get_node("AnimatedSprite2D").flip_h = false
	if direction.x < 0:
		parent.get_node("AnimatedSprite2D").flip_h = true
		
	if direction.x == 0:
		if parent.get_node("AnimatedSprite2D").flip_h == false:
			dir = "left"
		if parent.get_node("AnimatedSprite2D").flip_h == true:
			dir = "right"
			
		if dir == "left":
			parent.get_node("AnimatedSprite2D").flip_h = true
		if dir == "right":
			parent.get_node("AnimatedSprite2D").flip_h = false
func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	dash_timer -= delta
	
	if dash_timer > 0.0 and dash_timer <= 0.15:
		if parent.velocity.length() > (FRICTION * delta):
			parent.velocity -= parent.velocity.normalized() * (FRICTION * delta)
		
	elif dash_timer <= 0.0:
		parent.velocity = Vector2.ZERO
		if super.get_movement_input() != Vector2.ZERO:
			return move_state
		return idle_state
		
	else:
		parent.velocity += (get_movement_input() * delta * ACCEL)
		parent.velocity = parent.velocity.limit_length(DASH_MAX_SPEED)
		
	parent.move_and_slide()
	
	return null

func direction_facing_animation():
	if direction == Vector2(1,0):
		idle_state = $"../idle_side"
		move_state = $"../move_right"
	if direction == Vector2(-1,0):
		idle_state = $"../idle_side"
		move_state = $"../move_left"
	if direction == Vector2(0,1):
		idle_state = $"../idle_down"
		move_state = $"../move_down"
	if direction == Vector2(0,-1):
		idle_state = $"../idle_up"
		move_state = $"../move_up"

func get_movement_input():
	return direction
