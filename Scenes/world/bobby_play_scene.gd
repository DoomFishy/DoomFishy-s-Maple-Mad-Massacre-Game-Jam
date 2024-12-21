extends Node2D

func _ready():
	Global.on_boss_world += 1

func _on_audio_stream_player_2d_finished():
	$AudioStreamPlayer2D.play()
