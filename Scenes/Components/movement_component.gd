class_name MovementComponent
extends Node

@export var speed: float = 300.0

func handle_horizontal_movement(body: CharacterBody2D, direction: float) -> void:
	body.velocity.x = direction * speed
	flip_body(body)

func flip_body(body: CharacterBody2D) -> void:
	if body.velocity.x > 0.0:
		body.scale.x = body.scale.y * 1.0
	if body.velocity.x < 0.0:
		body.scale.x = body.scale.y * -1.0
