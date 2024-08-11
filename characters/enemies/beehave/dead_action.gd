extends ActionLeaf


func before_run(_actor: Node, _blackboard: Blackboard):
	character_sprite.play(Name.anim_dead)
	character_sprite.animation_finished.connect(_on_anim_finished)


func tick(_actor: Node, _blackboard: Blackboard):
	return RUNNING


func _on_anim_finished():
	character.speed = 0.0
	#character.queue_free()
