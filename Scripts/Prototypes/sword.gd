# Represents a prototype sword hazard/weapon that applies knockback to colliding bodies.
extends Area2D

# Magnitude of the knockback force applied upon impact.
@export var knockback_force: float = 600.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Unused ready lifecycle method.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# Triggered when another Area2D enters this area's collision bounds.
func _on_area_entered(area: Area2D) -> void:
	pass # Unused area collision handler.


# Triggered when a physics body enters the sword's collision area.
func _on_body_entered(body: Node2D) -> void:
	# Check if the colliding body supports receiving knockback.
	if body.has_method("apply_knockback"):
		# Calculate the normalized direction vector from the sword to the target body.
		var hit_direction = (body.global_position - global_position).normalized()
		
		# Apply the calculated knockback force along the hit direction vector.
		body.apply_knockback(hit_direction * knockback_force)
