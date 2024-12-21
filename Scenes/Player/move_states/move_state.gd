extends State

@export var idle_state : State
@export var MAX_SPEED = 600.0
@export var ACCEL = 10000
@export var FRICTION = 6500

func enter() -> void:
	super()

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:

	var input = Input.get_vector("left", "right", "up", "down")
			
	if input == Vector2.ZERO:
		if parent.velocity.length() > (FRICTION * delta):
			parent.velocity -= parent.velocity.normalized() * (FRICTION * delta)
		else:
			parent.velocity = Vector2.ZERO
			return idle_state

	else:
		parent.velocity += (input * delta * ACCEL)
		parent.velocity = parent.velocity.limit_length(MAX_SPEED)
									
	parent.move_and_slide()
	
	return null
