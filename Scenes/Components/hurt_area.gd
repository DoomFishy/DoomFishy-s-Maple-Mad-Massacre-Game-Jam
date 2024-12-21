extends Area2D

var attack_damage = 10

func _on_area_entered(area):
	if area is PlayerHitboxComponent:
		var hitbox: PlayerHitboxComponent = area
		
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		hitbox.damage(attack)
