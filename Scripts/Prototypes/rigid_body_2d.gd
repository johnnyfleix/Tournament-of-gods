# Prototype physics ball that reacts to external knockback impulses.
class_name Ball
extends RigidBody2D

# Applies an external knockback force vector to the ball.
func apply_knockback(force_vector: Vector2) -> void:
	# apply_central_impulse instantly shoots the rigid body forward from its center of mass.
	apply_central_impulse(force_vector)