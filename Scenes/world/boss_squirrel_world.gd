extends Node2D

@onready var animplayer = $boss_squirrel_opening_scene/AnimationPlayer
@onready var camera = $boss_squirrel_opening_scene/Path2D/PathFollow2D/Camera2D

var is_path_following = false
var is_open_cutscene = false

func _ready():
	is_open_cutscene = true
	Global.player.camera.enabled = false
	camera.enabled = true
	is_path_following = true
	
func _physics_process(delta):
	if is_open_cutscene:
		var pathfollower = $boss_squirrel_opening_scene/Path2D/PathFollow2D
		
		if is_path_following:
			pathfollower.progress_ratio += 0.006
			
			if pathfollower.progress_ratio >= 0.99:
				cutsceneclose()
				
func cutsceneclose():
	Global.opencutscene_bobby = false
	is_path_following = false
	is_open_cutscene = false
	camera.enabled = false
	Global.player.camera.enabled = true
	$boss_squirrel_opening_scene.visible = false
	$boss_squirrel_world_main.visible = true
