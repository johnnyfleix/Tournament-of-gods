# Main player character controller that delegates mechanics to modular components.
class_name Player

extends CharacterBody2D

# Component references and configuration for player abilities.
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var drop_down_collision_layer: int = 5
@export var jump_component: AdvancedJumpComponent
@export var attack_component: AttackComponent

# Tracks the current horizontal facing direction of the player.
var facing_direction: float = 1.0

# Called every physics tick to handle movement and character state updates.
func _physics_process(delta: float) -> void:
	_controller(delta)
	move_and_slide()


# Core controller logic coordinating input, attacks, movement, and gravity.
func _controller(delta: float) -> void:
	var input: InputComponent = input_component
	var movement: MovementComponent = movement_component
	var gravity: GravityComponent = gravity_component
	var jump: AdvancedJumpComponent = jump_component
	var attack: AttackComponent = attack_component
	var is_dropping: bool = input.get_drop_input()
	
	
	
	attack.sword_attack(self , input.get_attack_input())
	attack.shoot_attack(self , input.get_shoot_input())

	if attack.is_shooting:
		self.velocity = Vector2.ZERO
	else :
		gravity.handle_gravity(self , delta)
		movement.handle_horizontal_movement(self , input.get_horizontal_input())
		jump.handle_jump(self , input.get_jump_input() and not is_dropping, input.get_jump_input_released())

		if is_dropping:
			drop_down()




# Temporarily disables collision with one-way platforms to drop down through them.
func drop_down() -> void:
	set_collision_mask_value(drop_down_collision_layer, false)
	await get_tree().create_timer(0.4).timeout
	set_collision_mask_value(drop_down_collision_layer, true)
