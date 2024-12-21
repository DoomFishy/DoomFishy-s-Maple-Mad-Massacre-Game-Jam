extends State

func enter() -> void:
	super()
	parent.queue_free()
	
func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	return null
