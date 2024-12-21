extends State

@export var DEATH_SPEED := 250
@export var FRICTION := 450
@export var ACCEL := 58000

@onready var interact = preload("res://Scenes/interaction/exchange_interact.tscn")
@onready var interact_no = preload("res://Scenes/interaction/no_exchange_interact.tscn")

var player_pos
var slow_down = false
var direction

func enter() -> void:
	super()
	Global.has_beat_squirrel = true 
	create_interact_end()
	slow_down = false
	player_pos = Global.player
	direction = parent.global_position - player_pos.global_position
	
	await get_tree().create_timer(0.1).timeout
	slow_down = true
	await get_tree().create_timer(10).timeout	
	parent.queue_free()
	
func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	if slow_down:
		if parent.velocity.length() > (FRICTION * delta):
			parent.velocity -= parent.velocity.normalized() * (FRICTION * delta)
		else:
			parent.velocity = Vector2.ZERO
	else:
		parent.velocity += (direction * delta * ACCEL)
		parent.velocity = parent.velocity.limit_length(DEATH_SPEED)
	
	parent.move_and_slide()
	return null

func create_interact_end():
	var exchange_interact = interact.instantiate()
	var interact_1 = interact_no.instantiate()
	exchange_interact.global_position = Vector2(0,0)
	interact_1.global_position = Vector2(0,150)
	
	exchange_interact.scale.x = 3
	exchange_interact.scale.y = 3
	
	interact_1.scale.x = 3
	interact_1.scale.x = 3
	
	var level_scene = get_tree().get_root().get_node("squirrel_play_scene")
	level_scene.add_child(exchange_interact)
	level_scene.add_child(interact_1)
