# Base enemy chase state
class_name EnemyChaseState
extends State

var direction_to_player: Vector2

func state_enter():
	actor.current_speed = actor.current_speed * actor.speed_multiplier
	
	direction_to_player = actor.position.direction_to(actor.player_node.position)
	actor.direction_target = direction_to_player


func state_exit():
	actor.current_speed = actor.speed_init


func update_process(_delta):
	if actor.player_in_range == false:
		state_switched.emit(self, "EnemyWanderState")
	if actor.can_attack == true:
		state_switched.emit(self, "EnemyAttackState")
