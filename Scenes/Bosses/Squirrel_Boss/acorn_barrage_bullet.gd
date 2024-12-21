extends CharacterBody2D

var attack_damage := 5

func _ready():
	$AnimationPlayer.play("fall")

func shake():
	Global.camera.apply_shake(2)

func _on_hurtbox_area_entered(area):
	if area is PlayerHitboxComponent:
		var hitbox: PlayerHitboxComponent = area
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		hitbox.damage(attack)
