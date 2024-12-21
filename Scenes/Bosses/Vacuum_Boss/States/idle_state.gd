extends State

@export var dash_state: State
@export var suck_state: State
@export var dust_state: State
@export var summon_state: State

var player_pos 
var in_close_area = false
var rng 
var can_spawn = true
var is_dead = false

func enter() -> void:
	super()
	
	await get_tree().create_timer(3).timeout
	
	parent.get_node("CollisionShape2D").disabled = false
	can_spawn = true
	player_pos = Global.player_pos
	rng = RandomNumberGenerator.new()
	
func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	if not is_dead:
		if Global.opencutscene_vacuum:
			var tween = get_tree().create_tween()
			tween.tween_property(parent.get_node("gui/healthbar"), "modulate:a", 1, 0.2)
			
		if Global.opencutscene_vacuum == false:
			player_pos = Global.player_pos
			var direction = player_pos - parent.global_position
			var distance = direction.length()
			rng = RandomNumberGenerator.new()
			var rand
			
			if distance < 350 and distance > 10:
				rand = rng.randi_range(1,75)
				
				if rand == 1:
					rand = rng.randi_range(1,2)
					if rand == 1:
						return summon_state
					else:
						return dust_state
				
			if distance > 300:
				rand = rng.randi_range(1,125)
				if rand == 1:
					return suck_state

			if in_close_area == true:
				rand = rng.randi_range(1,50)
				if rand == 1:
					return dash_state
	return null

func is_dead_():
	is_dead = true

func _on_too_close_dash_area_entered(area):
	if area is PlayerHitboxComponent:
		in_close_area = true

func _on_too_close_dash_area_exited(area):
	if area is PlayerHitboxComponent:
		in_close_area = false

