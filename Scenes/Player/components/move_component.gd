extends Node

func get_movement_direction():
	return Input.get_vector("left", "right", "up", "down")

func want_dash():
	return Input.is_action_just_pressed("dash")
