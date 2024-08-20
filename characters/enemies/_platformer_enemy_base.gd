class_name PlatformerEnemyBase
extends PlatformerCharacterBase

@onready var state_machine: StateMachine = $StateMachine

@export var can_attack: bool
@export var player_in_range: bool
@export var detection_length: int


func initilize_stats():
	super()
	detection_length = Stats.character_stats[self_id]["detection_length"]
