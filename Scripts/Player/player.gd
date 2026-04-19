class_name Player

extends CharacterBody2D

@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var jump_component: AdvancedJumpComponent

func _physics_process(delta: float) -> void:
	_controller(delta)
	move_and_slide()


func _controller(delta: float) -> void:
	var input: InputComponent = input_component
	var movement: MovementComponent = movement_component
	var gravity: GravityComponent = gravity_component
	var jump: AdvancedJumpComponent = jump_component
	gravity.handle_gravity(self , delta)
	movement.handle_horizontal_movement(self , input.get_horizontal_input())
	jump.handle_jump(self , input.get_jump_input(), input.get_jump_input_released())