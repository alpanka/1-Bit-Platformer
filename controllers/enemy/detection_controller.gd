## Controller to detect if player is in range
class_name DetectionController
extends Node2D

@export var detection_length: int

@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight

@onready var character: PlatformerEnemyBase = get_owner()


func _ready() -> void:
	_update_detection_length()


func _physics_process(_delta: float) -> void:
	_detection_checker()


func _update_detection_length() -> void:
	detection_length = Stats.character_stats[character.self_id]["detection_length"]
	ray_cast_left.target_position.y = detection_length
	ray_cast_right.target_position.y = detection_length


func _detection_checker():
	if ray_cast_left.get_collider() is PlayerCharacter\
	or ray_cast_right.get_collider() is PlayerCharacter:
		character.player_in_range = true
	else:
		character.player_in_range = false
