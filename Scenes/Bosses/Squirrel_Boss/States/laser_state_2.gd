extends State

@export var idle_state: State
@export var barrage_state: State

var laser_horizontal = preload("res://Scenes/Bosses/Squirrel_Boss/laser_horizontal.tscn")
var laser_vertical = preload("res://Scenes/Bosses/Squirrel_Boss/laser_vertical.tscn")

var player_global_pos
var return_idle_state = false
var laser_instances_limit = 0

func enter() -> void:
	super()
	print("in laser state")
	player_global_pos = Global.player_pos
	if laser_instances_limit <= 2:
		load_lasers_horizontal()
		load_lasers_vertical()
	await get_tree().create_timer(1).timeout
	laser_instances_limit = 0
	return_idle_state = true
	
func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	if return_idle_state:
		return idle_state
	return null

func load_lasers_horizontal():
	var tween = get_tree().create_tween()
	tween.tween_property(parent.get_node("Acorn_1"), "position", player_global_pos, 0.4)
	await get_tree().create_timer(0.4).timeout
	
	laser_instances_limit += 1
	var laser = laser_horizontal.instantiate()
	laser.global_position = player_global_pos
	laser.scale.y = 2
	laser.scale.x = 3
	
	get_parent().add_child(laser)
	
func load_lasers_vertical():
	var tween = get_tree().create_tween()
	tween.tween_property(parent.get_node("Acorn_2"), "position", player_global_pos, 0.4)
	await get_tree().create_timer(0.4).timeout
	
	laser_instances_limit += 1
	var laser = laser_vertical.instantiate()
	laser.global_position = player_global_pos
	laser.scale.y = 2
	laser.scale.x = 3
	
	get_parent().add_child(laser)
