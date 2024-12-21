extends State

@export var DEATH_SPEED := 250
@export var FRICTION := 450
@export var ACCEL := 58000

var player_pos
var slow_down = false
var direction

func enter() -> void:
	super()
	Global.roomba_num -= 1
	slow_down = false
	player_pos = Global.player
	direction = parent.global_position - player_pos.global_position
	
	await get_tree().create_timer(0.1).timeout
	slow_down = true
	await get_tree().create_timer(10).timeout	
	parent.queue_free()
	
func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	if slow_down:
		if parent.velocity.length() > (FRICTION * delta):
			parent.velocity -= parent.velocity.normalized() * (FRICTION * delta)
		else:
			parent.velocity = Vector2.ZERO
	else:
		parent.velocity += (direction * delta * ACCEL)
		parent.velocity = parent.velocity.limit_length(DEATH_SPEED)
	
	parent.move_and_slide()
	return null
