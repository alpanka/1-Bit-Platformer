##
## Character's area where it hurts
##
class_name HurtboxController
extends BoxControllerBase


func _ready() -> void:
	controller_area_init()
	cooldown_timer.wait_time = 0.6


func got_hit(_damage_amount: int) -> void:
	if cooled_down:
		# Get character node of the hurtbox
		get_owner().apply_damage(_damage_amount)
		# Damage cooldown
		cooled_down = false
		cooldown_timer.start()
