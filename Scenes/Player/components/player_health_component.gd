extends Node

@export var MAX_HEALTH := 75

@onready var healthbar = get_parent().get_node("hud/player_healthbar")

var direction: Vector2
var health: float
var hurt

func _ready():
	healthbar.init_health(100)
	healthbar.set_health(Global.player_health)
	
func _process(delta):
	if Global.player_health <= 0:
		get_tree().change_scene_to_file("res://Scenes/Main/dead_screen.tscn")
		
	if hurt:
		get_parent().get_node("hitbox/CollisionShape2D").disabled = true
		get_parent().velocity = Vector2.ZERO
		await get_tree().create_timer(0.2).timeout
		hurt = false

func damage(attack: Attack):
	get_parent().get_node("audio/hit").play()
	Global.camera.apply_shake(2)
	hurt = true
	get_parent().get_node("hit_anim").play("hit_flash")
	Global.player_health -= attack.attack_damage
	healthbar.set_health(Global.player_health)
	var tween = get_tree().create_tween().set_loops(4)
	
	tween.tween_property(get_parent().get_node("AnimatedSprite2D"), "modulate:a", 0.2, 0.1)
	tween.tween_property(get_parent().get_node("AnimatedSprite2D"), "modulate:a", 0.6, 0.1)
	await tween.finished
	tween.stop()
	get_parent().get_node("AnimatedSprite2D").set_indexed("modulate:a", 1)
	get_parent().get_node("hitbox/CollisionShape2D").disabled = false
	
