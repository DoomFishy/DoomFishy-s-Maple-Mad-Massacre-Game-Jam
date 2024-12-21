extends State

@export var idle_state: State

var player_pos
var return_to_idle = false
var dust_ball = preload("res://Scenes/Bosses/Vacuum_Boss/projectiles/dust_projectile.tscn")
var shadow_dust_ball = preload("res://Scenes/Bosses/Vacuum_Boss/projectiles/dust_shadow.tscn")

func enter() -> void:
	super()
	return_to_idle = false
	player_pos = Global.player_pos
			
	
func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	player_pos = Global.player_pos
	
	if return_to_idle:
		return idle_state
	return null
	
func idle():
	return_to_idle = true
	
func spawn_dust():
	var dust = dust_ball.instantiate()
	dust.scale.x = 3.5
	dust.scale.y = 3.5
	dust.global_position = parent.global_position
	get_parent().add_child(dust)

