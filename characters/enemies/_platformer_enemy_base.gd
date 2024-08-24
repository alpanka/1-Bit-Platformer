class_name PlatformerEnemyBase
extends PlatformerCharacterBase


@export var player_in_range: bool
@export var detection_length: int

@export var can_attack: bool
@export var attack_range: float
@export var damage_amount: float

var player_node: PlayerCharacter


func _process(_delta: float) -> void:
	pass


func initilize_stats():
	super()
	detection_length = Stats.character_stats[self_id]["detection_length"]
	attack_range = Stats.character_stats[self_id]["attack_range"]
	damage_amount = Stats.character_stats[self_id]["damage_amount"]
	
	player_node = get_tree().get_first_node_in_group("Player")


func update_direction(_direction):
	if _direction == null:
		return
	
	if state_machine:
		if current_state == "EnemyChaseState":
			direction = player_node.position.direction_to(self.position)
		if current_state == "EnemyWanderState":
			direction = _direction
	
	direction = _direction

func attack():
	pass
