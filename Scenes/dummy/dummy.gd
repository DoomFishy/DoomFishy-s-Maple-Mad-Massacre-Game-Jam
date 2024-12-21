extends CharacterBody2D

func damage(attack: Attack):
	get_node("AnimatedSprite2D").play("hit")
