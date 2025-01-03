class_name Squirrel_boss
extends CharacterBody2D

@onready var animations = $AnimationPlayer
@onready var state_machine = $"state_machine"
@onready var laser_state_machine = $"laser_state_machine"
@onready var move_component = $"move_component"

func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	state_machine.init(self, animations, move_component)
	laser_state_machine.init(self, animations, move_component)
	Global.current_boss = "Squirrel_boss"
	
func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:							
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
