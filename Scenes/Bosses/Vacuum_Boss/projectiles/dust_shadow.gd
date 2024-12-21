extends Sprite2D

var attack_damage = 15

func _ready():
	await get_tree().create_timer(2).timeout
	$hitbox/CollisionShape2D.disabled = true
	await get_tree().create_timer(5).timeout
	queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("dust"):
		$hitbox/CollisionShape2D.set_deferred("disabled", false)
		Global.camera.apply_shake(4)
		$dust_explosion.emitting = true

		body.queue_free()
		await get_tree().create_timer(0.65).timeout
		call_deferred("queue_free")
		
func _on_hitbox_area_entered(area):
	if area is PlayerHitboxComponent:
		var hitbox: PlayerHitboxComponent = area
		
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		hitbox.damage(attack)
		$hitbox/CollisionShape2D.disabled = true
