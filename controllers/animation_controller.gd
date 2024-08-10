##
## Adjust facing direction of a character
##
class_name CharacterAnimationController
extends Node2D


@export var character: CharacterBody2D:
	set(value):
		if is_instance_valid(character):
			character.direction_changed.disconnect(_on_direction_changed)
			#character.state_changed.disconnect(_on_state_changed)
		
		character = value
		
		## Connect to character's direction_changed signal
		if is_instance_valid(character):
			character.direction_changed.connect(_on_direction_changed)
			#character.state_changed.connect(_on_state_changed)

var character_state


func _process(_delta: float) -> void:
	pass


func animation_adjuster():
	pass


#func _on_state_changed(_old_state, _new_state):
	#character_state = _new_state
	#if _new_state == character.STATE.RUN:
		#character.character_sprite.play("run")
	#if _new_state == character.STATE.IDLE:
		#if _old_state == character.STATE.RUN:
			#character.character_sprite.stop()
		#else:
			#character.character_sprite.play("idle")
	#if _new_state == character.STATE.DEATH:
		#character.character_sprite.play("dead")



func _on_direction_changed(_direction):
	if _direction.x == 0:
		return
	
	var facing_direction = sign(_direction.x)
	
	if facing_direction == 1:
		character.character_sprite.flip_h = false
	if facing_direction == -1:
		character.character_sprite.flip_h = true
