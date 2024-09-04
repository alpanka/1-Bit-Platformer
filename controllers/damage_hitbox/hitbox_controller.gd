##
## HitBox controller scene
## Apply damage to entity's Area2D (DamageReceiver)
##
class_name HitboxController
extends Area2D

@export var controller_area_auto_set: bool = true

@onready var controller_area: CollisionShape2D = $HitboxArea
@onready var cooldown_timer: Timer = $CooldownTimer

var cool_down_duration: float = 0.3
var cooled_down: bool = true

# Character node and its collision area
var collision_area: CollisionShape2D
var owner_node: Node2D

# Stats of the damaging object
var damager_stats: Dictionary

var can_damage: bool
var hurtbox_area: DamageReceiver


func _ready() -> void:
	_controller_area_init()
	_damage_amount_init()
	
	self.connect("area_entered", _on_area_entered)
	cooldown_timer.connect("timeout", _on_cooled_down_timeout)


func _physics_process(delta: float) -> void:
	_apply_damage(hurtbox_area)


func _on_area_exited(area: Area2D) -> void:
	if area is DamageReceiver:
		can_damage = false


## Apply damage on DamageReceiver/Area2D
func _on_area_entered(area: Area2D) -> void:
	# Check if damageable
	if area is not DamageReceiver:
		return
	else:
		can_damage = true
		hurtbox_area = area


func _apply_damage(hurtbox_area):
	if hurtbox_area == null:
		return

	if not can_damage:
		return
	
	# Check if cooled down
	if not cooled_down:
		return
	else:
		cooled_down = false
		cooldown_timer.start()
	
	# Update knockback vector based on direction between hitbox and hurtbox_area
	if "knockback_force" in damager_stats:
		if damager_stats["knockback_force"] > 0.0:
			var knockback_direction: Vector2
			knockback_direction = self.global_position.direction_to(hurtbox_area.global_position)
			damager_stats["knockback_direction"] = knockback_direction * damager_stats["knockback_force"]
	
	hurtbox_area.damage_received(damager_stats)


func _on_cooled_down_timeout() -> void:
	cooled_down = true


## damage_amount from owner()
func _damage_amount_init():
	# Checking the type of the object
	if owner_node is PlatformerCharacterBase:
		damager_stats = Stats.character_stats[owner_node.self_id]
	elif owner_node is ProjectileBase:
		damager_stats = Stats.projectile_stats[owner_node.self_id]
	else:
		print("Unidentified damage source.")


## Copy character's collision shape details.
## Apply them to Controller area shape.
func _controller_area_init() -> void:
	controller_area.debug_color = Color(0.8, 0, 0, 0.1)
	owner_node = get_owner()
	
	
	if controller_area_auto_set == false:
		return
	
	# Find parent's collision shape
	for child in get_owner().get_children():
		if child is CollisionShape2D:
			if child.name == "CharacterCollisionShape":
				push_warning("Shape set for ", child.name)
				collision_area = child

	# Apply gotten shape properties to hurtbox
	controller_area.shape = collision_area.shape
	controller_area.position = collision_area.position
