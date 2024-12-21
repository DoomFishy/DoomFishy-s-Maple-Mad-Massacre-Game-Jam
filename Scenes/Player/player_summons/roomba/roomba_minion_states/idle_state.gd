extends State

@export var chase_state: State

var return_to_chase = false

func enter() -> void:
	super()
	return_to_chase = false

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	if return_to_chase:
		return chase_state
	return null

func _on_enemy_chase_detect_area_entered(area):
	if area is HitboxComponent:
		return_to_chase = true
