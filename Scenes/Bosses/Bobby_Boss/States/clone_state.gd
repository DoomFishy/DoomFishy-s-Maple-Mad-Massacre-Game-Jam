extends State

@export var idle_state: State

var rng = RandomNumberGenerator.new()
var bobby_clone = preload("res://Scenes/Bosses/Bobby_Boss/bobby_clone.tscn")

var return_idle_state = false

func enter() -> void:
	super()
	return_idle_state = false
	for i in 10:
		summon()
	return_idle_state = true
func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	if return_idle_state:
		return idle_state
	return null

func summon():
	var clone = bobby_clone.instantiate()
	
	clone.position.y = rng.randi_range(-200, 200)
	clone.position.x = rng.randi_range(-500, 500)
	
	clone.scale.x = 3
	clone.scale.y = 3
	
	get_parent().add_child(clone)
