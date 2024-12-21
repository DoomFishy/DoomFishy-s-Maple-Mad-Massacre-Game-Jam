extends Node2D

var attack_damage
var crit_chance = 10

func _on_hurtbox_side_area_area_entered(area):
	if area is HitboxComponent:
		get_parent().get_node("audio/hurt_others").play()
		var rng = RandomNumberGenerator.new()
		var rand = rng.randi_range(1,100)
		
		var rng2 = RandomNumberGenerator.new()
		var rand2 = rng2.randi_range(2,8)
		
		attack_damage = rand2
		
		var hitbox: HitboxComponent = area
		
		var attack = Attack.new()
		attack.crit_chance = crit_chance
		attack.attack_damage = attack_damage
		
		var is_critical = attack.crit_chance > rand
		if is_critical:
			Global.crit = true
			attack.attack_damage *= 2
					
		hitbox.damage(attack)

func _on_hurtbox_up_area_area_entered(area):
	if area is HitboxComponent:
		get_parent().get_node("audio/hurt_others").play()
		var rng = RandomNumberGenerator.new()
		var rand = rng.randi_range(1,100)
		
		var rng2 = RandomNumberGenerator.new()
		var rand2 = rng2.randi_range(2,8)
		
		attack_damage = rand2
		
		var hitbox: HitboxComponent = area
		
		var attack = Attack.new()
		attack.crit_chance = crit_chance
		attack.attack_damage = attack_damage
		
		var is_critical = attack.crit_chance > rand
		if is_critical:
			Global.crit = true
			attack.attack_damage *= 2
			
					
		hitbox.damage(attack)

func _on_hurtbox_down_area_area_entered(area):
	if area is HitboxComponent:
		get_parent().get_node("audio/hurt_others").play()
		var rng = RandomNumberGenerator.new()
		var rand = rng.randi_range(1,100)
		
		var rng2 = RandomNumberGenerator.new()
		var rand2 = rng2.randi_range(2,8)
		
		attack_damage = rand2
		
		var hitbox: HitboxComponent = area
		
		var attack = Attack.new()
		attack.crit_chance = crit_chance
		attack.attack_damage = attack_damage
		
		var is_critical = attack.crit_chance > rand
		if is_critical:
			Global.crit = true
			attack.attack_damage *= 2
			
					
		hitbox.damage(attack)

func _on_slam_hurt_box_area_entered(area):
	if area is HitboxComponent:
		var rng = RandomNumberGenerator.new()
		var rand = rng.randi_range(1,100)
		
		var rng2 = RandomNumberGenerator.new()
		var rand2 = rng2.randi_range(4,12)
		
		attack_damage = rand2
		
		var hitbox: HitboxComponent = area
		
		var attack = Attack.new()
		attack.crit_chance = crit_chance
		attack.attack_damage = attack_damage
		
		var is_critical = attack.crit_chance > rand
		if is_critical:
			Global.crit = true
			attack.attack_damage *= 2
			
		hitbox.damage(attack)
