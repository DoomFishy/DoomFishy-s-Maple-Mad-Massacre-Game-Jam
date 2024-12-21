extends State

@export var idle_state: State

var return_to_idle = false

var roomba = preload("res://Scenes/Bosses/Vacuum_Boss/roomba_enemy.tscn")

func enter() -> void:
	super()
	return_to_idle = false
	var rng = RandomNumberGenerator.new()
	
	var rand = rng.randi_range(1,2)
	if rand == 1 and Global.roomba_num <= 3:
		summon()
		summon()
	if rand == 2 and Global.roomba_num <= 3:
		summon()
		summon()
		summon()
	return_to_idle = true
	
func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	if return_to_idle:
		return idle_state
	return null
	
func summon():
	if Global.roomba_num <= 3:
		var rng = RandomNumberGenerator.new()
		var rand = rng.randi_range(1,2)
		
		var minion = roomba.instantiate()
		
		if rand == 1:
			minion.position = Vector2(-600, randf_range(-300, 300))
		else:
			minion.position = Vector2(600, randf_range(-300, 300))
			
		minion.scale.x = 2
		minion.scale.y = 2
		get_parent().add_child(minion)
