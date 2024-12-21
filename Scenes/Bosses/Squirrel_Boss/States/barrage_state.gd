extends State

@export var idle_state: State
@export var laser_state_1: State
@export var laser_state_2: State

var nuts_barrage = preload("res://Scenes/Bosses/Squirrel_Boss/acorn_barrage_bullet.tscn")
var return_to_idle = false

func enter() -> void:
	super()
	return_to_idle = false
	spawn_barrage()
	
func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	if return_to_idle:
		var rng = RandomNumberGenerator.new()
		
		var rand = rng.randi_range(1,5)
		
		if rand <= 2:
			return laser_state_1
		if rand > 2 and rand <= 4:
			return laser_state_2
		else:
			return idle_state 
	return null

func spawn_barrage():
	for i in 30:
		if i == 15:
			return_to_idle = true
		var rng = RandomNumberGenerator.new()
		var position = Global.player_pos
		var nuts = nuts_barrage.instantiate()
		nuts.position.x = rng.randi_range(-600,600)
		nuts.position.y = rng.randi_range(-300,300)
		
		get_parent().add_child(nuts)
		await get_tree().create_timer(0.1).timeout


