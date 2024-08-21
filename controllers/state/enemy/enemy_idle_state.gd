## Base enemy idle state
class_name EnemyIdleState
extends State

@export var idle_duration: float = 3.0

@onready var idle_timer: Timer = Timer.new()


func state_enter():
	_set_idle_timer()
	actor.character_sprite.play("idle")


func update_process(delta):
	actor.current_speed = 0


func state_exit():
	actor.current_speed = actor.speed_init


func _set_idle_timer():
	add_child(idle_timer)
	idle_timer.name = "idle_timer"
	idle_timer.connect("timeout", _on_idle_timer_timeout)
	idle_timer.wait_time = idle_duration
	idle_timer.start()
	

func _on_idle_timer_timeout():
	state_switched.emit(self, "EnemyWanderState")
