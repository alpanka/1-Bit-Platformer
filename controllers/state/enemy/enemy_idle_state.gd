## Base enemy idle state
class_name EnemyIdleState
extends State

@export var idle_duration: float = 1.0


func state_enter():
	actor.character_sprite.play("idle")
	
	await get_tree().create_timer(idle_duration).timeout
	state_exit()


func state_exit():
	actor.current_speed = actor.speed_init
	state_switched.emit(self, "EnemyWanderState")


func update_process(_delta):
	actor.current_speed = 0
