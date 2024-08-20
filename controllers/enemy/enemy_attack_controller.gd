## Enemy attack behavior
class_name EnemyAttackController
extends Node2D

@export var attack_range: float
@export var can_attack: bool

@onready var character: PlatformerEnemyBase = get_owner()


func _ready() -> void:
	attack_range = Stats.character_stats[character.self_id]["attack_range"]


func _process(delta: float) -> void:
	_in_attack_range_checker()


func _in_attack_range_checker():
	var player_pos: Vector2 = character.player_node.global_position
	var distance_to_player: float = character.global_position.distance_to(player_pos)

	if distance_to_player <= attack_range:
		character.can_attack = true
	else:
		character.can_attack = false
