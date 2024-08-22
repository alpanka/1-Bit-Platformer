## Base class for StateMachine's states
class_name State
extends Node

signal state_switched

@export var actor: PlatformerCharacterBase


func _ready() -> void:
	actor = get_owner() as PlatformerCharacterBase

func state_enter() -> void:
	pass


func state_exit() -> void:
	pass


func update_process(_delta) -> void:
	pass


func update_physics(_delta) -> void:
	pass
