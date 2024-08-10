##
## Base class for HIT and HURT box
##
class_name BoxControllerBase
extends Area2D

@onready var controller_area: CollisionShape2D = $HurtboxArea2D
@onready var cooldown_timer: Timer = $CooldownTimer

@export var cool_down_duration: float
@export var cooled_down: bool = true

var character: PlatformerCharacterBase
var collision_area: CollisionShape2D


## Copy character's collision shape details.
## Apply them to Controller area shape.
func controller_area_init() -> void:
	# Find parent's collision shape
	for child in get_owner().get_children():
		if child is CollisionShape2D:
			print("got child ", child)
			collision_area = child

	# Apply gotten shape properties to hurtbox
	controller_area.shape = collision_area.shape
	controller_area.position = collision_area.position
	controller_area.debug_color = Color(0.8, 0, 0, 0.1)

## Turn damage/hit being applied on
func _on_cooldown_timer_timeout() -> void:
	cooled_down = true
