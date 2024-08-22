# Base enemy chase state
class_name EnemyChaseState
extends State


func state_enter():
	actor.current_speed = actor.current_speed * actor.speed_multiplier


func state_exit():
	actor.current_speed = actor.speed_init


func update_process(_delta):
	if actor.player_in_range == false:
		state_switched.emit(self, "EnemyWanderState")
	if actor.can_attack == true:
		state_switched.emit(self, "EnemyAttackState")
