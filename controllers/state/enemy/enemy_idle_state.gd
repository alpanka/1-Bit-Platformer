class_name EnemyIdleState
extends State

@export var animated_sprite: AnimatedSprite2D


func _enter():
	animated_sprite.play("idle")
