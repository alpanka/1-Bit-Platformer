# Base enemy attack state
class_name EnemyAttackState
extends State


func update_process(_delta):
	pass
	if actor.can_attack:
		actor.attack()
	else:
		state_switched.emit(self, "EnemyChaseState")
