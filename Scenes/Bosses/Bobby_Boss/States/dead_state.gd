extends State

@onready var interact = preload("res://Scenes/interaction/exchange_interact.tscn")
@onready var interact_no = preload("res://Scenes/interaction/no_exchange_interact.tscn")

func enter() -> void:
	super()
	Global.has_beat_bobby = true
	var destination = parent.global_position
	destination.y -= 1000
	
	var tween = get_tree().create_tween()
	tween.tween_property(parent, "position", destination, 2.5)
	
	await get_tree().create_timer(3).timeout
	create_interact()

	
func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	return null
	
func create_interact():
	var exchange_interact = interact.instantiate()
	var interact_1 = interact_no.instantiate()
	exchange_interact.global_position = Vector2(0,0)
	interact_1.global_position = Vector2(0,150)
	
	exchange_interact.scale.x = 3
	exchange_interact.scale.y = 3
	
	interact_1.scale.x = 3
	interact_1.scale.x = 3
	
	var level_scene = get_tree().get_root().get_node("bobby_play_scene")
	level_scene.add_child(exchange_interact)
	level_scene.add_child(interact_1)
	
	
