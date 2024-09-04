## Player input controller
class_name InputController
extends Node

@export var player: CharacterBody2D
@export var shooter_controller: ShooterController


func _process(_delta: float) -> void:
	## Player multi directional movement
	player.direction = Input.get_vector(
		Names.left, Names.right, Names.up, Names.down)


func _unhandled_input(_event: InputEvent) -> void:
	## Jump action
	if Input.is_action_just_pressed(Names.jump):
		player.jump_attempt()

	## Shoot action
	if Input.is_action_just_pressed(Names.attack):
		shooter_controller.shoot_attempt()
