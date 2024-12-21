class_name State
extends Node

@export
var animation_name: String

# Hold a reference to the parent so that it can be controlled by the state
var parent: CharacterBody2D
var animations: AnimationPlayer
var move_component

func enter() -> void:
	animations.play(animation_name)

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null

func get_movement_input():
	return move_component.get_movement_direction()
