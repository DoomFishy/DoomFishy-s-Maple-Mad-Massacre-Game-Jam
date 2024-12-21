extends State
class_name Hurt_State

@export var move_state: State
@export var idle_state: State

var direction: Vector2

func enter() -> void:
	super()
	direction = Vector2.ZERO
	
func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	return null
	
func finish():
	if super.get_movement_input() != Vector2.ZERO:
		return move_state
	return idle_state
	
func get_movement_input():
	return direction

func want_dash():
	return false
