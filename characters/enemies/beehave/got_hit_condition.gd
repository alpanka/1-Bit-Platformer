extends ConditionLeaf


var got_hit: bool


func tick(_actor: Node, _blackboard: Blackboard):
	got_hit = _blackboard.get_value(Name.got_hit_key, false)
	
	if got_hit:
		return SUCCESS
	else:
		return FAILURE
