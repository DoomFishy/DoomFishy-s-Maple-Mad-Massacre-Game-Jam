class_name maple_clone
extends CharacterBody2D

@onready var animations = $AnimationPlayer
@onready var state_machine = $"state_machine"
@onready var move_component = $"move_component"

func _ready() -> void:
	state_machine.init(self, animations, move_component)
	
func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	
func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func boom(value):
	Global.camera.apply_shake(value)
