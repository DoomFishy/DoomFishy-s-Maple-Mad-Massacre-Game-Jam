extends State

@export var idle_state: State

@onready var timer = $Timer
var laser_projectile = preload("res://Scenes/Player/player_summons/ancestors/laser.tscn")

var summon_num = 0

var return_to_idle = false

func enter() -> void:
	return_to_idle = false
	
	if summon_num < 3:
		spawn()
	else:
		return_to_idle = true
	
func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	if return_to_idle:
		return idle_state
	return null
	
func spawn():
	summon_num += 1
	timer.start()
	return_to_idle = true
	var laser = laser_projectile.instantiate()
	laser.scale.x = 2
	laser.scale.y = 2
	laser.global_position = parent.get_global_mouse_position()
	
	get_parent().add_child(laser)

func _on_timer_timeout():
	summon_num -= 1
