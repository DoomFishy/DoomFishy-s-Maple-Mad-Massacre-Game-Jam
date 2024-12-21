extends Node2D

@onready var animplayer = $Boss_vacuum_opening_cutscene/AnimationPlayer
@onready var camera = $Boss_vacuum_opening_cutscene/Path2D/PathFollow2D/Camera2D

var is_path_following = false
var is_open_cutscene = false

func _ready():
	
	is_open_cutscene = true
	Global.player.camera.enabled = false
	camera.enabled = true
	is_path_following = true
	
func _physics_process(delta):
	if is_open_cutscene:
		var pathfollower = $Boss_vacuum_opening_cutscene/Path2D/PathFollow2D
		
		if is_path_following:
			pathfollower.progress_ratio += 0.006
			
			if pathfollower.progress_ratio >= 1:
				cutsceneclose()
				
func cutsceneclose():
	Global.opencutscene_vacuum = false
	is_path_following = false
	is_open_cutscene = false
	camera.enabled = false
	Global.player.camera.enabled = true
	$Boss_vacuum_opening_cutscene.visible = false
	$Boss_vacuum_world_main.visible = true
