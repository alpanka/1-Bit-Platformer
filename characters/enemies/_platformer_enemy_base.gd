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
var damage: float

var player_node: PlayerCharacter


func _ready() -> void:
	initilize_stats()


## Enemy characters have additional variables that need to be set
func initilize_stats():
	# Run base stats
	super()
	
	# Run enemy base stats
	detection_length = Stats.character_stats[self_id]["detection_length"]
	attack_range = Stats.character_stats[self_id]["attack_range"]
	damage = Stats.character_stats[self_id]["damage"]
	
	# get player node
	player_node = get_tree().get_first_node_in_group("Player")
	
	# Get state_machine, connect to signal to get current state_name
	if state_machine:
		state_machine.connect("current_state_changed", _update_enemy_state_info)
	
	# Set starting focus to FREE
	current_focus = FOCUS.FREE



# Direction handler. Setting current direction based on state
# direction and direction_target
func direction_handler(_target: Vector2) -> void:
	self.direction = _target


#TODO Get back to it. Could be better
func attack():
	var attack_pos: Vector2 = self.global_position
	
	if can_attack:
		current_speed = 600
		await get_tree().create_timer(0.2).timeout
		
		var tween: Tween = get_tree().create_tween()
		tween.tween_property(self, "position", attack_pos, 0.1)
		
		current_speed = speed_init

# Manage knockback if damage object applies.
# Received from Hitbox
func apply_knockback(_knocback_direction: Vector2, _knockback_duration: float):
	is_free = false
	current_speed = 0
	#velocity.y -= 100.0
	velocity.x += _knocback_direction.x * speed_init
	move_and_slide()
	await get_tree().create_timer(_knockback_duration).timeout
	
	is_free = true
	current_speed = speed_init


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


func _character_death() -> void:
	var death_timer: float = 0.8
	print("DIED! ", self.name)
	
	is_alive = false
	character_sprite.play("death")
	Signals.enemy_died.emit(self.name)
	
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(character_sprite, "self_modulate", Color(1, 1, 1, 0.2), death_timer)
	
	await get_tree().create_timer(death_timer).timeout

	queue_free()
