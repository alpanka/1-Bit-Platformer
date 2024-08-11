extends ActionLeaf


func before_run(_actor: Node, _blackboard: Blackboard):
	character_sprite.animation_finished.connect(_on_animation_finished)
	
	anim_running = true
	character_sprite.play(Name.anim_got_hit)


func tick(_actor: Node, _blackboard: Blackboard):
	if anim_running == true:
		return RUNNING
	elif anim_running == false:
		_blackboard.set_value(Name.got_hit_key, false)
		return SUCCESS


func _on_animation_finished():
	character_sprite.animation_finished.disconnect(_on_animation_finished)
	character.direction = Vector2.ZERO
	anim_running = false
