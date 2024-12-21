extends State

@export var chase_state: State

var return_chase_state = false

func enter() -> void:
	super()
	Global.roomba_num += 1
	parent.velocity = Vector2.ZERO
	return_chase_state = false
	
func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	if return_chase_state:
		return chase_state
	return null

func _on_player_chase_detect_area_entered(area):
	if area is PlayerHitboxComponent:
		return_chase_state = true
		
