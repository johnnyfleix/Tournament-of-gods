# Represents a prototype sword hazard/weapon that applies knockback to colliding bodies.
extends Area2D

@export var knockback_origin: Marker2D
# Magnitude of the knockback force applied upon impact.
@export var knockback_force: float = 600.0

# Triggered when a physics body enters the sword's collision area.
func _on_body_entered(body: Node2D) -> void:
	# Check if the colliding body supports receiving knockback.
	if body.has_method("apply_knockback"):
		var origin = knockback_origin.global_position if knockback_origin else get_parent().global_position
		var hit_direction = (body.global_position - origin).normalized()
		# Apply the calculated knockback force along the hit direction vector.
		body.apply_knockback(hit_direction * knockback_force)