## Base scene/script for projectiles
class_name ProjectileBase
extends RigidBody2D

var self_id: String

@export var damage_amount: int
@export var initial_velocity: float
@export var magazine_count: int

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var hitbox_controller: HitboxController = $HitboxController


func _ready() -> void:
	initilize_stats()
	hitbox_controller.connect("area_entered", _on_hitbox_controller_area_entered)


func initilize_stats() -> void:
	damage_amount = Stats.projectile_stats[self_id]["damage"]
	initial_velocity = Stats.projectile_stats[self_id]["velocity"]
	magazine_count = Stats.projectile_stats[self_id]["magazine"]


func launch_projectile(_launch_direction: Vector2) -> void:
	linear_velocity = _launch_direction * initial_velocity


func _on_hitbox_controller_area_entered(area: Area2D) -> void:
	if area is HurtboxController:
		area.got_hit(damage_amount)
