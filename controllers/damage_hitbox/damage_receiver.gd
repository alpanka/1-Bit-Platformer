##
## Character's area where it hurts
##
class_name DamageReceiver
extends Area2D

@export var controller_area_auto_set: bool = true

@onready var damage_area: CollisionShape2D = $DamageArea

var collision_area: CollisionShape2D
var owner_node: Node2D


func _ready() -> void:
	_controller_area_init()


## Damage recived from HitBox
# TODO use additional properties that are set and can be set
# Such as knockback and its duration
#func apply_damage(_damage):
	#owner_node.apply_damage(_damage)
func damage_received(_hitbox_stats: Dictionary):
	var temp = _hitbox_stats
	print(temp)
	owner_node.apply_damage(_hitbox_stats["damage"])



func _controller_area_init() -> void:
	damage_area.debug_color = Color(0.8, 0, 0, 0.1)
	owner_node = get_owner()
	
	if controller_area_auto_set == false:
		return
	
	# Find parent's collision shape
	for child in get_owner().get_children():
		if child is CollisionShape2D:
			push_warning("Shape set for ", get_owner().name)
			collision_area = child

	# Apply gotten shape properties to hurtbox
	damage_area.shape = collision_area.shape
	damage_area.position = collision_area.position
	damage_area.debug_color = Color(0.8, 0, 0, 0.1)
