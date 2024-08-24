## Base scene/script for projectiles
class_name ProjectileBase
extends RigidBody2D

var self_id: String

@export var damage_amount: float
@export var initial_velocity: float
@export var magazine_count: int

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var hitbox_controller: HitboxController = $HitboxController

func _physics_process(delta: float) -> void:
	# Run upon collision
	if get_contact_count() >= 1:
		_on_projectile_colliding()


func initilize_stats() -> void:
	damage_amount = Stats.projectile_stats[self_id]["damage"]
	initial_velocity = Stats.projectile_stats[self_id]["velocity"]
	magazine_count = Stats.projectile_stats[self_id]["magazine"]


func launch_projectile(_launch_direction: Vector2) -> void:
	linear_velocity = _launch_direction * initial_velocity


# Queue fee on collision
func _on_projectile_colliding() -> void:
	self.freeze = true
	
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(animated_sprite, "modulate", Color(1, 1, 1, 0.005), 0.3)
	queue_free()
