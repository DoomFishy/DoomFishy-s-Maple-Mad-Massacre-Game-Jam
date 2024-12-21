extends CharacterBody2D

@onready var interaction_area: InteractionArea = $interaction_area
@onready var sprite = self

func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1, 0.2)
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	$AnimationPlayer.play("fade")
		
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.2)
	
	await get_tree().create_timer(0.2).timeout

func _on_interaction_area_area_entered(area):
	if area is PlayerHitboxComponent:
		$no_exchange.visible = true
	
func _on_interaction_area_area_exited(area):
	if area is PlayerHitboxComponent:
		$no_exchange.visible = false

func change_scene():
	if Global.has_beat_vacuum == true:
		if Global.has_beat_bobby == false:
			get_tree().change_scene_to_file("res://Scenes/world/bobby_play_scene.tscn")
		if Global.has_beat_squirrel == false:
			get_tree().change_scene_to_file("res://Scenes/world/squirrel_play_scene.tscn")
			
	if Global.has_beat_bobby == true:
		if Global.has_beat_vacuum == false:
			get_tree().change_scene_to_file("res://Scenes/world/vacuum_play_scene.tscn")
		if Global.has_beat_squirrel == false:
			get_tree().change_scene_to_file("res://Scenes/world/squirrel_play_scene.tscn")
			
	if Global.has_beat_squirrel == true:
		if Global.has_beat_vacuum == false:
			get_tree().change_scene_to_file("res://Scenes/world/vacuum_play_scene.tscn")
		if Global.has_beat_bobby == false:
			get_tree().change_scene_to_file("res://Scenes/world/bobby_play_scene.tscn")
			
	if Global.on_boss_world >= 3:
		get_tree().change_scene_to_file("res://Scenes/world/win_screen.tscn")
