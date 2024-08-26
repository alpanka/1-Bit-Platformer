##
## Reference to GLOBAL names
##
extends Node



## Input actions
var left: 	StringName = "ui_left"
var right: 	StringName = "ui_right"
var up: 	StringName = "ui_up"
var down: 	StringName = "ui_down"
var jump:	StringName = "jump"
var attack:	StringName = "attack"


## Animation names
var anim_idle:		StringName = "idle"
var anim_walk:		StringName = "walk"
var anim_detect:	StringName = "detect"
var anim_chase:		StringName = "chase"
var anim_attack:	StringName = "attack"
var anim_got_hit:	StringName = "got_hit"
var anim_dead:		StringName = "death"

## Scenes to instantiate/reference
## Projectiles
# Base projectile scene
var projectile_base: PackedScene = preload("res://weapons/projectiles/_projectile_base_scene.tscn")
# Level-1 projectile
var projectile_lvl1: PackedScene = preload("res://weapons/projectiles/projectile_lvl_1.tscn")

## Enemies
# Enemy invader scene
var enemy_invader: PackedScene = preload("res://characters/enemies/enemy_invader.tscn")



## Group names
var projectiles_group: String = "Projectiles"


## Blacboard keys
var is_alive_key:	StringName = "is_alive"
var got_hit_key:	StringName = "got_hit"
