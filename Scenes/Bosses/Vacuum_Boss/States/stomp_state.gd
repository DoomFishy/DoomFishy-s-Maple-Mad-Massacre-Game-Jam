extends State

@export var idle_state: State
@export var attack_damage := 10

var return_idle_state = false
var player_pos

func enter() -> void:
	super()
	return_idle_state = false
	player_pos = Global.player_pos
	
	parent.position = player_pos
	
func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	if return_idle_state:
		return idle_state
	return null

func return_to_idle_state():
	return_idle_state = true

func stomp_shake():
	Global.camera.apply_shake(4)

func _on_stomp_hitbox_area_entered(area):
	if area is PlayerHitboxComponent:
		var hitbox: PlayerHitboxComponent = area
		
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		hitbox.damage(attack)
