##
## HitBox controller scene
## Apply damage to entity's Area2D (DamageReceiver)
##
class_name HitboxController
extends Area2D

@export var controller_area_auto_set: bool = true

@onready var controller_area: CollisionShape2D = $HitboxArea
@onready var cooldown_timer: Timer = $CooldownTimer

var cool_down_duration: float = 0.2
var cooled_down: bool = true

var collision_area: CollisionShape2D
var owner_node: Node2D


func _ready() -> void:
	_controller_area_init()
	
	self.connect("area_entered", _on_area_entered)
	cooldown_timer.connect("timeout", on_cooled_down_timeout)


## Copy character's collision shape details.
## Apply them to Controller area shape.
func _controller_area_init() -> void:
	owner_node = get_owner()
	
	if controller_area_auto_set == false:
		controller_area.debug_color = Color(0.8, 0, 0, 0.1)
		return
	
	# Find parent's collision shape
	for child in get_owner().get_children():
		if child is CollisionShape2D:
			push_warning("Shape set for ", child.name)
			collision_area = child

	# Apply gotten shape properties to hurtbox
	controller_area.shape = collision_area.shape
	controller_area.position = collision_area.position
	controller_area.debug_color = Color(0.8, 0, 0, 0.1)


## Apply damage on DamageReceiver/Area2D
## damage_amount from owner()
func _on_area_entered(area: Area2D) -> void:
	if area is DamageReceiver:
		if cooled_down:
			cooled_down = false
			cooldown_timer.start()

			var damager_stats: Dictionary
			
			if owner_node is PlatformerCharacterBase:
				damager_stats = Stats.character_stats[owner_node.self_id]
			elif owner_node is ProjectileBase:
				damager_stats = Stats.projectile_stats[owner_node.self_id]
			else:
				print("Unidentified damage source.")
			
			area.damage_received(damager_stats)
			
			#area.apply_damage(Stats.projectile_stats[owner_node.self_id]) # This will send a dict
			#area.apply_damage(ownder_node.damage)
			#area.apply_damage(owner_node.self_id)


func on_cooled_down_timeout() -> void:
	cooled_down = true
