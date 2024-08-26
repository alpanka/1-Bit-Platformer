# Base enemy wander state
class_name EnemyWanderState
extends State


func state_enter():
	actor.character_sprite.play(Name.anim_walk)
	actor.current_speed = actor.speed_init


func update_process(_delta):
	if actor.player_in_range:
		actor.character_sprite.play(Name.anim_detect)
		await actor.character_sprite.animation_finished
		
		state_switched.emit(self, "EnemyChaseState")
	elif actor.can_attack:
		actor.character_sprite.play(Name.anim_detect)
		await actor.character_sprite.animation_finished
		
		state_switched.emit(self, "EnemyAttackState")
