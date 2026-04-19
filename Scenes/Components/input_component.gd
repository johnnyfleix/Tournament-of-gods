class_name InputComponent

extends Node

var input_horizontal: float = 0.0

func _process(delta: float) -> void:
	get_horizontal_input()
	get_jump_input()

func get_horizontal_input() -> float:
	input_horizontal = Input.get_axis("move_left", "move_right")
	return input_horizontal

func get_jump_input() -> bool:
	return Input.is_action_just_pressed("jump")

func get_jump_input_released() -> bool:
	return Input.is_action_just_released("jump")