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

# Variables to see if player in range for CHASE
var player_in_range: bool
var detection_length: int

# Variables to see if enemy can ATTACK
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
	self.direction = _target


#TODO needs work
func attack():
	var target_pos: Vector2
	var self_pos: Vector2
	target_pos = player_node.global_position
	self_pos = global_position
	
	if can_attack:
		self.velocity.x += 100



# Update state.name when changed.
# Signal from state_machine
func _update_enemy_state_info(_new_state) -> void:
	# Set current state name
	current_state = _new_state
	
	# Update focus based on current_state
	match current_state:
		"EnemyIdleState":
			current_focus = FOCUS.FREE
		"EnemyWanderState":
			current_focus = FOCUS.FREE
		"EnemyChaseState":
			current_focus = FOCUS.CHASE
		"EnemyAttackState":
			current_focus = FOCUS.ATTACK
