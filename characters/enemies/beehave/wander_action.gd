extends ActionLeaf

@export var is_alive: bool
@export var got_hit: bool
@export var current_direction: Vector2


func tick(_actor: Node, _blackboard: Blackboard):
	got_hit = _blackboard.get_value(Name.got_hit_key, false)
	is_alive = _blackboard.get_value(Name.is_alive_key, true)
	current_direction = character.direction

	if is_alive == false or got_hit == true:
		return FAILURE
	elif current_direction.x != 0:
		return RUNNING
	else:
		return FAILURE
