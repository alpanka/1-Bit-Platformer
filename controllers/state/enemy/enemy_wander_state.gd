# Base enemy wander state
class_name EnemyWanderState
extends State


func state_enter():
	actor.character_sprite.play("walk")
	actor.current_speed = actor.speed_init


func update_process(delta):
	if actor.player_in_range:
		state_switched.emit(self, "EnemyChaseState")
