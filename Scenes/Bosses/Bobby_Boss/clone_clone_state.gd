extends State

@export var idle_state: State

func process_physics(delta: float) -> State:
	return idle_state
