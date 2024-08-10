extends Node

@export var character: PlatformerCharacterBase
@export var blackboard: Blackboard


func _ready() -> void:
	character.is_alive_changed.connect(_on_is_alive_changed)
	blackboard.set_value(Name.is_alive_key, character.is_alive)


func _on_is_alive_changed(_alive_state: bool):
	blackboard.set_value(Name.is_alive_key, character.is_alive)
