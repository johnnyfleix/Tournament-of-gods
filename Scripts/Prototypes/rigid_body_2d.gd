# Prototype physics ball that reacts to external knockback impulses.
class_name Ball
extends RigidBody2D

@export var explosion_particles: GPUParticles2D

# Applies an external knockback force vector to the ball.
func apply_knockback(force_vector: Vector2) -> void:
	# apply_central_impulse instantly shoots the rigid body forward from its center of mass.
	apply_central_impulse(force_vector)

func _on_body_entered(body: Area2D) -> void:
	print("Pew pew")
	if body.is_in_group("bullets"):
		print("Ocuhies")
		explosion_particles.emitting = true
		await explosion_particles.finished
		queue_free()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullets"):
		explosion_particles.emitting = true
		await explosion_particles.finished
		queue_free()
