extends Node
class_name HealthComponent

@export var MAX_HEALTH := 1
@export var dead_state: State

@onready var healthbar = get_parent().get_node("healthbar")
@onready var bosshealthbar = get_parent().get_node("gui/healthbar")

var health: float
var shader_material
var enemy_type = null

var player_pos = Vector2.ZERO
var direction = Vector2.ZERO

var has_just_died = false

func _ready():
	if healthbar != null:
		enemy_type = "enemy"
		bosshealthbar = healthbar
	else:
		enemy_type = "boss"
		healthbar = bosshealthbar
	
	health = MAX_HEALTH
	healthbar.init_health(MAX_HEALTH)
	shader_material = get_parent().get_node("AnimatedSprite2D").material
	
func damage(attack: Attack):
	player_pos = Global.player_pos
	direction = get_parent().global_position - player_pos
	
	Global.camera.apply_shake(1)
	
	if enemy_type == "enemy":
		print("move!")
		get_parent().velocity = 350 * direction.normalized()
		
		get_parent().move_and_slide()
	
	
	if health > 0:
		DamageNumbers.display_number(attack.attack_damage, self.global_position, Global.crit)
		health -= attack.attack_damage
		healthbar.set_health(health)
		
		if health <= (MAX_HEALTH/2):
			print("is half")
			Global.is_half_hp = true
			
		Global.crit = false
		
		shader_material.set_shader_parameter("active", true) 
		await get_tree().create_timer(0.2).timeout
		shader_material.set_shader_parameter("active", false) 
	
	if health <= 0:
		if enemy_type == "boss":
			if not has_just_died:
				get_parent().get_node("state_machine/idle_state").is_dead_()
		if not has_just_died:
			get_parent().get_node("state_machine").force_change_state(dead_state)
		get_parent().get_node("AnimationPlayer").play("dead")
		has_just_died = true
		Global.is_half_hp = false
