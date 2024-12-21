extends CharacterBody2D

@onready var interaction_area: InteractionArea = $interaction_area
@onready var sprite = self

func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1, 0.2)
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	Global.in_tutorial = false
	$AnimationPlayer.play("fade")
		
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.2)
	
	await get_tree().create_timer(0.2).timeout

func change_scene():
	var rng = RandomNumberGenerator.new()
	var rand = rng.randi_range(0,2)
	
	if rand == 0:
		get_tree().change_scene_to_file("res://Scenes/world/bobby_play_scene.tscn")
	elif rand == 1:
		get_tree().change_scene_to_file("res://Scenes/world/squirrel_play_scene.tscn")
	elif rand == 2:
		get_tree().change_scene_to_file("res://Scenes/world/vacuum_play_scene.tscn")
