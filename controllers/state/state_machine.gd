## StateMachine
## State switcher, handler
class_name  StateMachine
extends Node

@export var states_dict: Dictionary = {}
@export var initial_state: State
@export var current_state: State


func _ready() -> void:
	for child in get_children():
		if child is State:
			print(child)
			print(child.name)
			states_dict[child.name] = child
			child.state_switched.connect(change_state)
	
	if initial_state:
		initial_state.state_enter()
		current_state = initial_state
	else:
		print("Failed to init a state of ", self.name)


func _process(delta: float) -> void:
	if current_state:
		current_state.update_process(delta)


func _physics_process(delta: float) -> void:
	if current_state:
		current_state.update_physics(delta)


func change_state(source_state: State, new_state_name: String):
	if source_state != current_state:
		print("Invalid change_state attempt on from ", \
		source_state.name, " to ", new_state_name)
		return

	var new_state = states_dict.get(new_state_name)
	
	if not new_state:
		print("New state is empty! ", new_state_name)
		return
	
	new_state.state_enter()
	
	current_state = new_state

# Use when absolutely needed. Like for "DeathState"
func change_state_forced(new_state_name: String):
	var new_state = states_dict.get(new_state_name)
	
	if not new_state:
		print("New state is empty! ", new_state_name)
		return

	if current_state == new_state:
		print("Attempt to push current state. Aborted.")
		return
	
	if current_state:
		var exit_callable = Callable(current_state, "exit")
		exit_callable.call_deferred()
	
	new_state.state_enter()
	
	current_state = new_state
