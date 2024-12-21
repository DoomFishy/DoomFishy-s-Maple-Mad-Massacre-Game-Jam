extends State

@export var idle_state: State
@export var original_pos := Vector2(-1, -95)
@export var dash_distance := 500.0
@export var attack_damage := 10
@export var dash_time := 0.35
@export var red_timer := 0.5

var return_to_idle = false

var player_pos = Vector2.ZERO
var direction = Vector2.ZERO
var destination_pos = Vector2.ZERO

func enter() -> void:
	super()
	return_to_idle = false
	dashing()
	
func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	
	if return_to_idle == true:
		return idle_state
	return null
	
func turn_red():
	find_destination()
	var tween = get_tree().create_tween()
	tween.tween_property(parent.get_node("AnimatedSprite2D"), "modulate:g", 0, 0.01)
	tween.tween_property(parent.get_node("AnimatedSprite2D"), "modulate:b", 0, 0.01)

func turn_normal():
	var tween = get_tree().create_tween()
	tween.tween_property(parent.get_node("AnimatedSprite2D"), "modulate:g", 1, 0.01)
	tween.tween_property(parent.get_node("AnimatedSprite2D"), "modulate:b", 1, 0.01)

func dashing():
	await get_tree().create_timer(1).timeout
	parent.get_node("CollisionShape2D").disabled = true
	var tween = get_tree().create_tween()
	find_destination()
	
	turn_red()
	await get_tree().create_timer(red_timer).timeout
	tween = get_tree().create_tween()
	tween.tween_property(parent, "position", destination_pos, dash_time)
	if parent.global_position.x < -550 or parent.global_position.x > 550:
		parent.global_position = Vector2.ZERO
	if parent.global_position.y < -350 or parent.global_position.y > 350:
		parent.global_position = Vector2.ZERO	
	parent.get_node("Dash_hitbox/CollisionShape2D").disabled = false
	await get_tree().create_timer(dash_time).timeout
	parent.get_node("Dash_hitbox/CollisionShape2D").disabled = true
	turn_normal()
	
	await get_tree().create_timer(1).timeout
	find_destination()
	
	turn_red()
	await get_tree().create_timer(red_timer).timeout
	tween = get_tree().create_tween()
	tween.tween_property(parent, "position", destination_pos, dash_time)
	if parent.global_position.x < -550 or parent.global_position.x > 550:
		parent.global_position = Vector2.ZERO
	if parent.global_position.y < -350 or parent.global_position.y > 350:
		parent.global_position = Vector2.ZERO	
	parent.get_node("Dash_hitbox/CollisionShape2D").disabled = false
	await get_tree().create_timer(dash_time).timeout
	parent.get_node("Dash_hitbox/CollisionShape2D").disabled = true
	turn_normal()
	
	await get_tree().create_timer(1).timeout
	find_destination()
	
	turn_red()
	await get_tree().create_timer(red_timer).timeout
	tween = get_tree().create_tween()
	tween.tween_property(parent, "position", destination_pos, dash_time)
	if parent.global_position.x < -550 or parent.global_position.x > 550:
		parent.global_position = Vector2.ZERO
	if parent.global_position.y < -350 or parent.global_position.y > 350:
		parent.global_position = Vector2.ZERO		
	parent.get_node("Dash_hitbox/CollisionShape2D").disabled = false
	await get_tree().create_timer(dash_time).timeout
	parent.get_node("Dash_hitbox/CollisionShape2D").disabled = true
	turn_normal()
	
	await get_tree().create_timer(1).timeout
	find_destination()

	turn_red()
	await get_tree().create_timer(red_timer).timeout
	tween = get_tree().create_tween()
	tween.tween_property(parent, "position", destination_pos, dash_time)
	if parent.global_position.x < -550 or parent.global_position.x > 550:
		parent.global_position = Vector2.ZERO
	if parent.global_position.y < -350 or parent.global_position.y > 350:
		parent.global_position = Vector2.ZERO		
	parent.get_node("Dash_hitbox/CollisionShape2D").disabled = false
	await get_tree().create_timer(dash_time).timeout
	parent.get_node("Dash_hitbox/CollisionShape2D").disabled = true
	turn_normal()
	
	await get_tree().create_timer(1).timeout

	parent.get_node("Dash_hitbox/CollisionShape2D").disabled = true
	return_to_idle = true

func find_destination():
	player_pos = Global.player_pos
	direction = (player_pos - parent.global_position).normalized()
	destination_pos = parent.global_position.lerp(player_pos, dash_distance / parent.global_position.distance_to(player_pos))

func _on_dash_hitbox_area_entered(area):
	if area is PlayerHitboxComponent:
		var hitbox: PlayerHitboxComponent = area
		
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		hitbox.damage(attack)
