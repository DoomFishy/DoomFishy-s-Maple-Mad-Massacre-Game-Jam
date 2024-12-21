extends CharacterBody2D

var player_pos
var direction
var attack_damage = 5

func _ready():
	player_pos = Global.player_pos
	direction = (player_pos - global_position).normalized()
	
func _physics_process(delta):
	velocity = 500 * direction
	move_and_slide()

func set_direction(direction):
	direction = self.direction
	velocity = direction * 500

func _on_hurtbox_area_entered(area):
	if area is PlayerHitboxComponent:
		var hitbox: PlayerHitboxComponent = area
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		hitbox.damage(attack)
