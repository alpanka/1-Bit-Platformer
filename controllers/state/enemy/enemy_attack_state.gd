# Base enemy attack state
class_name EnemyAttackState
extends State

@export var attack_cooldown_dur: float = 0.8
var cooled_down: bool = true


func update_process(_delta):
	if actor.can_attack and cooled_down:
		print("Attack")
		actor.attack()
		cooled_down = false
		
		await get_tree().create_timer(attack_cooldown_dur).timeout
		cooled_down = true
		
	elif actor.player_in_range and not actor.can_attack:
		state_switched.emit(self, "EnemyChaseState")
	elif not actor.player_in_range and not actor.can_attack:
		state_switched.emit(self, "EnemyIdleState")
