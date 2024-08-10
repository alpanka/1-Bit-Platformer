extends ConditionLeaf

var character_alive: bool
var is_dead: bool

func tick(_actor: Node, _blackboard: Blackboard):
	character_alive = _blackboard.get_value(Name.is_alive_key, true)
	is_dead = not character_alive
	
	if is_dead:
		return SUCCESS
	else:
		return FAILURE
