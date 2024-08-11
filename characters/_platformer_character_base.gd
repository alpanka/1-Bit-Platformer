##
## Base class for all paltformer characters
##
class_name PlatformerCharacterBase
extends CharacterBody2D

## Emit direction change
signal direction_changed(direction: Vector2)
## Emit alive status
signal is_alive_changed(alive_state: bool)
## Emit health change
#signal health_changed(old_value: int, new_value: int)
## Emit damage received
signal damage_received(damage_amount)
## Emit state change
#signal state_changed(old_state: STATE, new_state: STATE)

var self_id: String

@export var character_sprite: AnimatedSprite2D

@export var speed: float

@export var jump_force: float
@export var can_ground_jump: bool
@export var can_air_jump: bool


@export var health_init: int
@export var current_health: int


# Direction change setter, emitter
var direction: Vector2:
	set(value):
		if direction == value:
			return
		#if direction.x * value.x <= 0: # Emit if X changed
		direction = value
		direction_changed.emit(direction)

# Set is_alive and emit when changed
var is_alive: bool = true:
	set(value):
		if is_alive == value:
			return
	
		is_alive = value
		is_alive_changed.emit(is_alive)


#enum STATE {
	#IDLE 	= 0,
	#WALK 	= 1,
	#RUN 	= 2,
	#JUMP	= 3,
	#ATTACK 	= 10,
	#DAMAGED	= 11,
	#DEATH 	= 20
#}


func _ready() -> void:
	# Apply stats. Using self_id from _init() on instances
	initilize_stats()


func _physics_process(delta: float) -> void:
	_movement_handler(delta)


# Initilize character specific stats
func initilize_stats() -> void:
	if self_id:
		speed = Stats.character_stats[self_id]["speed"]
		jump_force = Stats.character_stats[self_id]["jump_force"]
		can_ground_jump = Stats.character_stats[self_id]["can_ground_jump"]
		can_air_jump = Stats.character_stats[self_id]["can_air_jump"]
		health_init = Stats.character_stats[self_id]["health_init"]
	else:
		print("failed to assign self_id ", self.name)
		return

	current_health = health_init


# Apply damage from hurtbox controller
func apply_damage(_damage_amount):
	damage_received.emit(_damage_amount)
	
	if current_health >= 0:
		current_health = current_health - _damage_amount
		print(_damage_amount, " damage on ", self.name)
	
	if current_health <= 0:
		_character_death()


func jump_attempt() -> bool:
	if is_on_floor() and can_ground_jump:
		_jump()
		return true
	else:
		return false


func _jump() -> void:
	velocity.y -= jump_force


func _movement_handler(delta) -> void:
	# Apply gravity
	var gravity: Vector2 = get_gravity()
	velocity.x += gravity.x * delta
	velocity.y += gravity.y * delta

	# Apply movement
	velocity.x = direction.x * speed
	move_and_slide()


# TODO Add death animation.
func _character_death() -> void:
	is_alive = false
	print("DIED! ", self.name)
	
	#queue_free()
