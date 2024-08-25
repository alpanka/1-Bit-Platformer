## Draft script for Vector math
extends Node

@onready var player: Sprite2D = $player
@onready var enemy: Sprite2D = $enemy
@onready var target: Sprite2D = $target


var enemy_pos: Vector2
var player_pos: Vector2
var target_pos: Vector2
var target_dist: float

func _ready() -> void:
	_check_sprite_locations()


func _check_sprite_locations():
	enemy_pos = enemy.global_position
	player_pos = player.global_position
	
	print("ENEMY POS: ", enemy.global_position)
	print("PLAYER POS: ", player.global_position)
	print("TARGET POS: ", target.global_position, "\n")

	target_dist = enemy_pos.distance_to(player_pos)
	target_pos.x = enemy_pos.x - target_dist * 2
	
	print("POS ", target_pos)
	print("DIST ", target_dist)
