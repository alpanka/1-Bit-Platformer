##
## Base class for all paltformer characters
##
class_name PlayerCharacter
extends PlatformerCharacterBase


func _init() -> void:
	self_id = "player"
	initilize_stats()


func _ready() -> void:
	Signals.player_health_changed.emit(current_health, 0)


# Apply damage from hurtbox controller
func apply_damage(_damage_amount):
	super(_damage_amount)
	#damage_received.emit(_damage_amount)
	Signals.player_health_changed.emit(current_health, _damage_amount)
