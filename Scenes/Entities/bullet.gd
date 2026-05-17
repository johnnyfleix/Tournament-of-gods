# Represents a projectile entity that travels horizontally and applies knockback on impact.
extends Area2D

# Movement speed of the projectile in pixels per second.
@export var speed: float = 800
# Knockback force applied to targets upon collision.
@export var knockback_force: float = 20.0
# Direction of movement along the horizontal axis.
var move_direction: float = 1.0

# Called when the node enters the scene tree for the first time. Initializes direction and scale.
func _ready() -> void:
	move_direction = sign(global_position.x)

	global_scale.x = abs(global_scale.x)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	fire_bullet(delta)

# Translates the bullet along its local X axis based on speed and delta time.
func fire_bullet(delta: float) -> void:
	move_local_x(speed * delta)

# Cleans up the bullet instance when its lifetime timer expires.
func _on_bullet_life_time_timeout() -> void:
	queue_free()


# Triggered when a physics body enters the bullet's collision area.
func _on_body_entered(body: Node2D) -> void:
	# Check if the colliding body supports receiving knockback.
	if body.has_method("apply_knockback"):
		# Calculate the normalized direction vector from the bullet to the target body.
		var hit_direction = (body.global_position - global_position).normalized()
		
		# Apply the calculated knockback force along the hit direction vector.
		body.apply_knockback(hit_direction * knockback_force)
