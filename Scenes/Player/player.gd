class_name Player
extends CharacterBody2D

@onready var animations = $AnimationPlayer
@onready var movement_state_machine = $"movement_state_machine"
@onready var attack_state_machine = $attack_state_machine
@onready var vacuum_power_state_machine = $vacuum_power_state_machine
@onready var move_component = $move_component
@onready var camera = $Camera2D

func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	Global.player = self
	Global.player_pos = self.global_position
	Global.camera = $Camera2D
	$weapon/hurtbox_down_area/hurtbox_down.disabled = true
	$weapon/hurtbox_side_area/hurtbox_side.disabled = true
	$weapon/hurtbox_up_area/hurtbox_up.disabled = true
	$hitbox/CollisionShape2D.disabled = false
	movement_state_machine.init(self, animations, move_component)
	attack_state_machine.init(self, animations, move_component)
	vacuum_power_state_machine.init(self, animations, move_component)
	
func _unhandled_input(event: InputEvent) -> void:
	movement_state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	movement_state_machine.process_physics(delta)
	print(Global.player_health)
	Global.player_pos = self.global_position

func _process(delta: float) -> void:
	movement_state_machine.process_frame(delta)
	if Global.has_exchange_vacuum:
		$vacuum_appearance.visible = true
		$AnimatedSprite2D.visible = false
	else:
		$vacuum_appearance.visible = false
		$AnimatedSprite2D.visible = true
