class_name PlatformerEnemyBase
extends PlatformerCharacterBase

@onready var state_machine: StateMachine = $StateMachine
@onready var state_label: Label = $StateLabel

@export var player_in_range: bool
@export var detection_length: int

@export var can_attack: bool
@export var attack_range: float

@export var state_label_active: bool = true

var player_node: PlayerCharacter


func _process(delta: float) -> void:
	_set_state_label_text()


func initilize_stats():
	super()
	detection_length = Stats.character_stats[self_id]["detection_length"]
	attack_range = Stats.character_stats[self_id]["attack_range"]
	
	player_node = get_tree().get_first_node_in_group("Player")


func _set_state_label_text():
	if state_machine.current_state:
		if state_label_active:
			state_label.text = state_machine.current_state.name
