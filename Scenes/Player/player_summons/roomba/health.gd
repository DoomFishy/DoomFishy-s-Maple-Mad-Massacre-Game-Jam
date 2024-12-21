extends Node
class_name health_comp

@export var MAX_HEALTH := 1
@export var dead_state: State

var health: float
var shader_material

var direction = Vector2.ZERO

var has_just_died = false

func _ready():
	shader_material = get_parent().get_node("AnimatedSprite2D").material
	
func damage(attack: Attack):
	Global.camera.apply_shake(1)
	
	get_parent().velocity = 350 * direction.normalized()
	get_parent().move_and_slide()
	
	if health <= 0:
		get_parent().get_node("state_machine").force_change_state(dead_state)
		get_parent().get_node("AnimationPlayer").play("dead")
		has_just_died = true
