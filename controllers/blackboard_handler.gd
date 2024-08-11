extends Node

@onready var character: PlatformerCharacterBase = get_owner()
@export var blackboard: Blackboard


func _ready() -> void:
	blackboard.set_value(Name.is_alive_key, character.is_alive)
	blackboard.set_value(Name.got_hit_key, false )

	character.damage_received.connect(_on_damage_received)
	character.is_alive_changed.connect(_on_is_alive_changed)


func _on_damage_received(_damage_received):
	blackboard.set_value(Name.got_hit_key, true)


func _on_is_alive_changed(_alive_state: bool):
	blackboard.set_value(Name.is_alive_key, character.is_alive)
