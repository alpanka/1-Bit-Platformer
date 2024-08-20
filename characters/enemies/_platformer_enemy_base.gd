class_name PlatformerEnemyBase
extends PlatformerCharacterBase

@onready var state_machine: StateMachine = $StateMachine

@export var player_in_range: bool
@export var detection_length: int

@export var can_attack: bool
@export var attack_range: float

var player_node: PlayerCharacter


func initilize_stats():
	super()
	detection_length = Stats.character_stats[self_id]["detection_length"]
	attack_range = Stats.character_stats[self_id]["attack_range"]
	
	player_node = get_tree().get_first_node_in_group("Player")
