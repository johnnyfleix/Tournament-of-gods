class_name Bullet

# Represents a projectile entity that travels horizontally and applies knockback on impact.
extends Area2D
@export var knockback_origin: Marker2D
# Movement speed of the projectile in pixels per second.
@export var speed: float = 800
# Knockback force applied to targets upon collision.
@export var knockback_force: float = 20.0
# Direction of movement anlong the horizontal axis.
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
func _on_body_entered(_body: Node2D) -> void:
	queue_free()
