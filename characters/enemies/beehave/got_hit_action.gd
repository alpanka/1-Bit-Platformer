extends ActionLeaf


func before_run(_actor: Node, _blackboard: Blackboard):
	character_sprite.animation_finished.connect(_on_animation_finished)
	character_sprite.play(Name.anim_got_hit)
	anim_running = true


func tick(_actor: Node, _blackboard: Blackboard):
	if anim_running:
		return RUNNING
	else:
		_blackboard.set_value(Name.got_hit_key, false)
		return SUCCESS


func _on_animation_finished():
	anim_running = false
	#character_sprite.animation_finished.disconnect(_on_animation_finished)
