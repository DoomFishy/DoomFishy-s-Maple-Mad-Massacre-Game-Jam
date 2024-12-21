extends State

@export var boom_state: State
@export var speed := 100
@export var accel := 50

var enemy_direction
var return_boom = false
func enter() -> void:
	super()
	return_boom = false

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
		
	var direction = enemy_direction - parent.global_position
	var angle = atan2(direction.y, direction.x)
	
	if abs(angle) < PI/4:
		parent.get_node("AnimatedSprite2D2").flip_h = true
	else:
		parent.get_node("AnimatedSprite2D2").flip_h = false
			
	if return_boom:
		return boom_state
		
	parent.velocity += (delta * accel * direction.normalized())
	parent.velocity = parent.velocity.limit_length(speed)
	parent.move_and_slide()
	
	return null

func _on_enemy_chase_detect_area_entered(area):
	if area is HitboxComponent:
		enemy_direction = area.global_position

func _on_enemy_boom_detect_area_entered(area):
	if area is HitboxComponent:
		return_boom = true
