extends State

@export var dead_state: State
@export var attack_damage := 2

var return_dead_state = false
var shader_material

func enter() -> void:
	super()
	return_dead_state = false
	shader_material = parent.get_node("AnimatedSprite2D").material
	parent.velocity = Vector2.ZERO
	
	parent.get_node("AnimationPlayer").play("boom")
	await parent.get_node("AnimationPlayer").animation_finished
	parent.queue_free()
	
func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	return null

func _on_enemy_boom_hurt_area_entered(area):
	if area is HitboxComponent:
		var hitbox: HitboxComponent = area
	
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		hitbox.damage(attack)

