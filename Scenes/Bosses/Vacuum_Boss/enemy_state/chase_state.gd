extends State

@export var idle_state: State
@export var boom_state: State
@export var dead_state: State

@export var speed := 250
@export var accel := 500

var return_boom_state = false
var player_pos
var direction = Vector2.ZERO
var rng = RandomNumberGenerator.new()

func enter() -> void:
	super()
	speed = rng.randi_range(100, 250)
	return_boom_state = false
	player_pos = Global.player_pos
	
func exit() -> void:
	parent.velocity = Vector2.ZERO

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	if return_boom_state:
		return boom_state
	
	player_pos = Global.player_pos
	direction = player_pos - parent.global_position
	
	parent.velocity += (direction.normalized() * delta * accel)
	parent.velocity = parent.velocity.limit_length(speed)
	
	parent.move_and_slide()
	
	return null

func dead():
	return dead_state

func _on_player_boom_detect_area_entered(area):
	if area is PlayerHitboxComponent:
		return_boom_state = true
