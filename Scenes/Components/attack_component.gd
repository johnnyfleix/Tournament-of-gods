# Component responsible for managing melee (sword) and ranged (shooting) attack actions.
class_name AttackComponent
extends Node

# References to required nodes for playing animations and spawning projectiles.
@export var camer_fx: CameraFx
@export var anim_player: AnimationPlayer
@export var muzzle: Marker2D
@export var shoot_timer: Timer

# Preloaded bullet scene to instantiate when firing.
var bullet: PackedScene = preload("res://Scenes/Entities/bullet.tscn")
# Stores the initial local position of the muzzle marker.
var muzzle_pos: Vector2
# Tracks whether a melee attack is currently in progress.
var is_attacking: bool
# Tracks whether the character is currently actively shooting.
var is_shooting: bool = false

# Called when the node enters the scene tree. Caches the muzzle position.
func _ready():
	muzzle_pos = muzzle.position

# Triggers a melee sword attack animation if the attack action is pressed.
func sword_attack(body: CharacterBody2D, attack_pressed: bool) -> void:
	if body and attack_pressed and not is_shooting:
		is_attacking = true
		anim_player.play("attack")

# Handles ranged shooting mechanics, stopping character movement and spawning bullets on a timer.
func shoot_attack(body: CharacterBody2D, trigger_held: bool) -> void:
	if body and trigger_held:
		is_shooting = true
		body.velocity.x = 0
		
		if shoot_timer.is_stopped():
			_spawn_hell_blanks()
			shoot_timer.start()
	else:
		is_shooting = false


# Instantiates and spawns a bullet projectile at the muzzle's global transform.
func _spawn_hell_blanks() -> void:
	var bullet_instance = bullet.instantiate()
	bullet_instance.global_transform = muzzle.global_transform
	get_tree().current_scene.add_child(bullet_instance)
	camer_fx.trigger_shake()
