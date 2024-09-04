##
## Reference to GLOBAL stats of this and that
##
extends Node


## Character stats
var character_stats: Dictionary = {
	"player" = {
		"speed_init": 160,
		"speed_multiplier": 1.8,
		"jump_force": 260,
		"can_ground_jump": true,
		"can_air_jump": true,
		"health_init": 100,
		"knockback_multiplier": 0.8,
	},
	"enemy_invader" = {
		"speed_init": 10.0,
		"speed_multiplier": 1.2,
		"jump_force": 0.0,
		"can_ground_jump": false,
		"can_air_jump": false,
		"health_init": 50,
		"knockback_multiplier": 1.25,
		"detection_length": 50,
		"attack_range": 15.0,
		"damage": 10
	}
}

## Projectile stats
var projectile_stats: Dictionary = {
	# Projectile Base Class
	"ProjectileBase" = {
		"damage": 0.0,
		"velocity": 000.0,
		"magazine": 00,
		"knockback_force": 0.0,
		"knockback_duration": 0.0
	},
	# Level-1 Projectile
	"ProjectileLvl1" = {
		"damage": 10.0,
		"velocity": 600.0,
		"magazine": 10,
		"knockback_force": 250.0,
		"knockback_duration": 0.2,
		"knockback_direction": Vector2.ZERO,
	}
}
