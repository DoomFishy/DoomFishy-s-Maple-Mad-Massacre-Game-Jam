extends Node2D


func _on_button_pressed():
	Global.player_health = 75
	Global.has_beat_vacuum = false
	Global.has_beat_squirrel = false
	Global.has_beat_bobby = false
	Global.timer = 0
	Global.has_exchange_vacuum = false
	get_tree().reload_current_scene()
	get_tree().change_scene_to_file("res://Scenes/Main/main_menu.tscn")
	
