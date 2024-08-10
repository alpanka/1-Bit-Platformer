extends ActionLeaf

var character: PlatformerCharacterBase
var character_sprite: AnimatedSprite2D


func _ready() -> void:
	character = get_owner()
	character_sprite = character.character_sprite


func before_run(_actor: Node, _blackboard: Blackboard):
	character_sprite.play(Name.anim_dead)
	character_sprite.animation_finished.connect(_on_anim_finished)


func tick(_actor: Node, _blackboard: Blackboard):
	return RUNNING


func _on_anim_finished():
	character.queue_free()
