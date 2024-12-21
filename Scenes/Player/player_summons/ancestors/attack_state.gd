extends State

@export var idle_state: State

@export var attack_front_state: State
@export var attack_side_state: State
@export var attack_back_state: State

@export var time_to_attack := 1.5

@export var ATTACK_MAX_SPEED = 250.0
@export var ACCEL = 6400
@export var FRICTION = 12800

var attack_timer := 0.0
var direction
var return_to_idle = false

func enter() -> void:
	super()
	return_to_idle = false
	parent.velocity = Vector2.ZERO
	
	direction = Global.player_pos - parent.global_position
	var angle = atan2(direction.y, direction.x)
	
	if abs(angle) < PI/4:
		parent.get_node("AnimatedSprite2D").flip_h = false
	else:
		parent.get_node("AnimatedSprite2D").flip_h = true
		
	attack_timer = time_to_attack
	
func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	if return_to_idle:
		return idle_state
	return null

func finish_attack():
	return_to_idle = true

func move_attack():
	var direction_1 = Global.player_pos
	var tween = get_tree().create_tween()
	tween.tween_property(parent, "position",direction_1, 0.5)
	await tween.finished


func _on_attack_detect_player_area_entered(area):
	pass # Replace with function body.


func _on_attack_detect_player_body_entered(body):
	pass # Replace with function body.


func _on_attack_intervals_timeout():
	pass # Replace with function body.
