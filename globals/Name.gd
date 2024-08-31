##
## Reference to GLOBAL names
##
extends Node



## Input actions
const left: 	StringName = "ui_left"
const right: 	StringName = "ui_right"
const up: 		StringName = "ui_up"
const down: 	StringName = "ui_down"
const jump:		StringName = "jump"
const attack:	StringName = "attack"



## Animation names
const anim_idle:		StringName = "idle"
const anim_walk:		StringName = "walk"
const anim_detect:		StringName = "detect"
const anim_chase:		StringName = "chase"
const anim_attack:		StringName = "attack"
const anim_got_hit:		StringName = "got_hit"
const anim_dead:		StringName = "death"



## Scenes to instantiate/reference
## Projectiles
# Base projectile scene
const PROJECTILE_BASE_SCENE: PackedScene = preload("res://weapons/projectiles/_projectile_base_scene.tscn")
# Level-1 projectile
const PROJECTILE_LVL1_SCENE: PackedScene = preload("res://weapons/projectiles/projectile_lvl_1.tscn")

## Enemies
# Enemy base scene
const PLATFORMER_ENEMY_BASE: PackedScene = preload("res://characters/enemies/_platformer_enemy_base.tscn")
# Enemy invader scene
const ENEMY_INVADER_SCENE: PackedScene = preload("res://characters/enemies/enemy_invader.tscn")

## UI Scenes
# Damage pop scene
const DAMAGE_POP_SCENE: PackedScene = preload("res://ui/damage_pop.tscn")



## Group names
const projectiles_group: String = "Projectiles"
