extends State

@export var chase_state: State

@export var attack_front_state: State
@export var attack_side_state: State
@export var attack_back_state: State

var return_to_chase = false
var is_dead = false

func enter() -> void:
	super()
	await get_tree().create_timer(3).timeout
	
	return_to_chase = false
	parent.velocity = Vector2.ZERO
	
func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	if return_to_chase and Global.player.camera.enabled:
		return chase_state
	return null

func is_dead_():
	is_dead = true

func _on_chase_detect_player_area_entered(area):
	if area is PlayerHitboxComponent:
		return_to_chase = true

