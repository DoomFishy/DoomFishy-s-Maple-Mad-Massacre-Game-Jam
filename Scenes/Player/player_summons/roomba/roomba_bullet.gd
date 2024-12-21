extends CharacterBody2D

@export var attack_damage := 4

const SPEED = 600.0
var bounce = 0
var direction: Vector2 = Vector2.ZERO

func _ready():
	direction = get_global_mouse_position() - Global.player_pos

func _physics_process(delta):
	if bounce > 3:
		queue_free()
	
	velocity = direction.normalized() * SPEED

	move_and_slide()

func _on_hurtbox_area_entered(area):
	if area is HitboxComponent:
		var hitbox: HitboxComponent = area
	
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		hitbox.damage(attack)


func _on_hit_wall_check_body_entered(body):
	if body.is_in_group("environment"):
		bounce += 1
		direction *= -1
		direction = direction.rotated(deg_to_rad(45))
