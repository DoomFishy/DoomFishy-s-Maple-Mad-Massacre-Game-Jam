extends State

@export var idle_state: State
var move_pos = [Vector2(-441,-196), Vector2(-441,196), Vector2(441,-196), Vector2(441,196), Vector2(0,0)]

var return_to_idle = false

func enter() -> void:
	super()
	return_to_idle = false
	
	var rng = RandomNumberGenerator.new()
	
	var rand = rng.randi_range(0,4)
	
	var tween = get_tree().create_tween()
	tween.tween_property(parent, "position", move_pos[rand], 0.5)
	await get_tree().create_timer(0.5).timeout
	return_to_idle = true
	
func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	if return_to_idle:
		return idle_state
	return null
