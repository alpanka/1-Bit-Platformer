# Base enemy attack state
class_name EnemyAttackState
extends State

@export var attack_cooldown_dur: float = 0.8
var cooled_down: bool = true
var chase_condition: bool
var idle_condition: bool


func update_process(_delta):
	chase_condition = actor.player_in_range and not actor.can_attack
	idle_condition = not actor.player_in_range and not actor.can_attack
	
	# Attack if in range and cooled_down
	if actor.can_attack and cooled_down:
		actor.character_sprite.play(Names.anim_attack)
		
		actor.attack()
		cooled_down = false
		await get_tree().create_timer(attack_cooldown_dur).timeout
		cooled_down = true
	# Chase if in range
	elif chase_condition:
		state_switched.emit(self, "EnemyChaseState")
	#elif idle_condition:
		#await get_tree().create_timer(0.2).timeout
		#if idle_condition:
			#state_switched.emit(self, "EnemyIdleState")
