##
## Reference to GLOBAL stats of this and that
##
extends Node


## Character stats
var character_stats: Dictionary = {
	"player" = {
		"speed": 160,
		"jump_force": 260,
		"can_ground_jump": true,
		"can_air_jump": true,
		"health_init": 100
	},
	"enemy_invader" = {
		"speed": 20.0,
		"jump_force": 0.0,
		"can_ground_jump": false,
		"can_air_jump": false,
		"health_init": 50
	}
}

## Projectile stats
var projectile_stats: Dictionary = {
	# Projectile Base Class
	"ProjectileBase" = {
		"damage": 5.0,
		"velocity": 600.0,
		"magazine": 10
	},
	# Level-1 Projectile
	"ProjectileLvl1" = {
		"damage": 10.0,
		"velocity": 600.0,
		"magazine": 10
	}
}
