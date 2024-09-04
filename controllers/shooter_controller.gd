##
## Projectile fire scene/script
##
class_name ShooterController
extends Node2D

@export var character: CharacterBody2D
@onready var spawn_point: Marker2D = $SpawnPoint
@onready var ray_cast: RayCast2D = $RayCast2D


var projectile_scene: PackedScene = Names.PROJECTILE_LVL1_SCENE
var projectile_parent: Node2D


# TODO Add a cooldown timer
# Timer duration could be different for different projectiles
func _ready() -> void:
	projectile_parent = get_tree().get_first_node_in_group(Names.projectiles_group)


func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())


func shoot_attempt() -> bool:
	if not ray_cast.is_colliding():
		_shoot()
		return true
	else:
		return false


func _shoot() -> void:
	#character.current_state = character.STATE.ATTACK
	var projectile = projectile_scene.instantiate() as ProjectileBase
	var projectile_direction = Vector2.RIGHT.rotated(global_rotation)
	
	projectile.global_position = spawn_point.global_position
	projectile_parent.add_child(projectile)
	projectile.launch_projectile(projectile_direction)
