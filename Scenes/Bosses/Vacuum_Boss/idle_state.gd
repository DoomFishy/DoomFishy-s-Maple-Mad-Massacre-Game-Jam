extends State

func enter() -> void:
	parent.velocity.y = 0

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	return null

func _on_too_close_dash_area_entered(area):
	if area is PlayerHitboxComponent:
		pass
