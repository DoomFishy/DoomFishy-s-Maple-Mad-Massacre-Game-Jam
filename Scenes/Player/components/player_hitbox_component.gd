extends Area2D
class_name PlayerHitboxComponent

@export var health_component: Node

func damage(attack: Attack):
	if health_component:
		health_component.damage(attack)
