extends Node2D

var rng = RandomNumberGenerator.new()

func _ready():
	pass

func _process(delta):
	pass

func _on_button_pressed():
	get_tree().reload_current_scene()
	get_tree().change_scene_to_file("res://Scenes/world/tutorial_play_scene.tscn")
