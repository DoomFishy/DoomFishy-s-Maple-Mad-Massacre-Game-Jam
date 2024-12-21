extends State

@export var idle_state: State
@export var stomp_state: State

@export var suction_force := 5550
@export var suction_accel := 50

var player_suck = false
var player_pos = Vector2.ZERO
var direction_to_vacuum
var return_to_stomp = false

func enter() -> void:
	super()
	return_to_stomp = false
	player_suck = false
	
	player_pos = Global.player_pos
	await get_tree().create_timer(1.5).timeout
	return_to_stomp = true
	
func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	apply_suction_force(delta)
	
	if return_to_stomp:
		return stomp_state
	
	return null
	
func apply_suction_force(delta: float):
	player_pos = Global.player_pos
	direction_to_vacuum = (parent.global_position - player_pos).normalized()
	Global.player.velocity += (direction_to_vacuum * suction_force * delta)

func _on_suck_hitbox_body_entered(body):
	if body.name == "player":
		player_suck = true
	if body.is_in_group("enemy"):
		pass
	
