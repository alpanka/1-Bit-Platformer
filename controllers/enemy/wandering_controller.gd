class_name WanderingController
extends Node2D

# RayCast for wall collision
@onready var ray_cast_wall_right: RayCast2D = $RayCastWallRight
@onready var ray_cast_wall_left: RayCast2D = $RayCastWallLeft

# RayCast for floor collision
@onready var ray_cast_floor_right: RayCast2D = $RayCastFloorRight
@onready var ray_cast_floor_left: RayCast2D = $RayCastFloorLeft

# Direction reset timer
@onready var wander_direction_resetter: Timer = $WanderDirectionResetter


const RIGHT: 	Vector2 = Vector2.RIGHT
const LEFT: 	Vector2 = Vector2.LEFT
const STOP: 	Vector2 = Vector2.ZERO

var character: PlatformerCharacterBase


func _ready() -> void:
	character = get_owner()
	character.update_direction([LEFT, RIGHT].pick_random())


func _process(_delta: float) -> void:
	character.update_direction(_collision_checker())


## Check collision of RayCast2Ds and determine direction.
func _collision_checker():
	if not ray_cast_floor_right.is_colliding():
		return LEFT
	if not ray_cast_floor_left.is_colliding():
		return RIGHT

	if ray_cast_wall_right.is_colliding():
		return LEFT
	if ray_cast_wall_left.is_colliding():
		return RIGHT


# TODO add a timer to reset direction
func _on_direction_resetter_timeout() -> void:
	pass
