class_name PlatformerEnemyBase
extends PlatformerCharacterBase

# Direction in queue before it is assigned to direction
var direction_target: Vector2:
	set(target):
		if target == direction_target:
			return
		else:
			direction_handler(target)
			direction_target = target

# Set focus to determine what direction to pick
# FREE: Free to get any direction
# CHASE: Chase player
# ATTACK: Attack player
enum FOCUS {FREE, CHASE, ATTACK}
var current_focus

var player_in_range: bool
var detection_length: int

var can_attack: bool
var attack_range: float
var damage_amount: float

var player_node: PlayerCharacter


func _ready() -> void:
	initilize_stats()


## Enemy characters have additional variables that need to be set
func initilize_stats():
	super()
	
	detection_length = Stats.character_stats[self_id]["detection_length"]
	attack_range = Stats.character_stats[self_id]["attack_range"]
	damage_amount = Stats.character_stats[self_id]["damage_amount"]
	
	player_node = get_tree().get_first_node_in_group("Player")
	
	# Get state_machine, connect to signal to get current state_name
	if state_machine:
		state_machine.connect("current_state_changed", _update_enemy_state_info)
	
	current_focus = FOCUS.FREE


# Direction handler. Setting current direction based on state
# direction and direction_target
func direction_handler(_target: Vector2) -> void:
	print("3: direction change ", direction, " ", _target)
	self.direction = _target
	print("4: direction set ", direction)


#TODO needs work
func attack():
	var attack_target: Vector2
	var current_pos: Vector2
	attack_target = player_node.position - Vector2(20, 0)
	
	if can_attack:
		var tween: Tween = get_tree().create_tween()
		tween.tween_property(self, "position", attack_target, 0.3)
		tween.tween_property(self, "position", current_pos, 0.1)


# Update state.name when changed.
# Signal from state_machine
func _update_enemy_state_info(_new_state) -> void:
	print(_new_state)
	current_state = _new_state
	print(current_focus)
	match current_state:
		"EnemyIdleState":
			current_focus = FOCUS.FREE
		"EnemyWanderState":
			current_focus = FOCUS.FREE
		"EnemyChaseState":
			current_focus = FOCUS.CHASE
		"EnemyAttackState":
			current_focus = FOCUS.ATTACK

	print(current_focus)
