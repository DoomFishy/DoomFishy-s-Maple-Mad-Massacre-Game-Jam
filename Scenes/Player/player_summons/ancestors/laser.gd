extends CharacterBody2D

@export var attack_damage := 10

func _ready():
	$AnimationPlayer.play("laser_attack")


func _on_hurtbox_area_entered(area):
	if area is HitboxComponent:
		var hitbox: HitboxComponent = area
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		hitbox.damage(attack)
