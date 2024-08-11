extends ConditionLeaf

@export var got_hit: bool
@export var is_alive: bool
@export var wandering: bool

func tick(_actor: Node, _blackboard: Blackboard):
	got_hit = _blackboard.get_value(Name.got_hit_key, false)
	is_alive = _blackboard.get_value(Name.is_alive_key, true)

	if is_alive == true and character.direction.x !=0:
		if got_hit == false:
			return SUCCESS
