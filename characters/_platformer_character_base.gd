##
## Base class for all paltformer characters
##
class_name PlatformerCharacterBase
extends CharacterBody2D

## Emit direction change
## Used by animation controller
signal direction_changed(direction: Vector2)
## Emit alive status
#signal is_alive_changed(alive_state: bool)
## Emit health change
#signal health_changed(old_value: int, new_value: int)
## Emit damage received
#signal damage_received(damage_amount)


@export_group("Nodes")
@export var character_sprite: AnimatedSprite2D
@export var state_machine: StateMachine
@export var current_state: String

@export_group("Movement Variables")
@export var speed_init: float
@export var current_speed: float
@export var speed_multiplier: float
@export var is_free: bool = true

@export_group("Jump Variables")
@export var jump_force: float
@export var can_ground_jump: bool
@export var can_air_jump: bool

@export_group("Health Variables")
@export var health_init: int
@export var current_health: int
@export var knockback_multiplier: float
@export var damageable: bool = true
@export var is_alive: bool = true

var self_id: String

# Current direction on movement
var direction: Vector2:
	set(value):
		if direction == value:
			return
		#if direction.x * value.x <= 0: # Emit if X changed
		direction = value
		direction_changed.emit(direction)

# Set is_alive and emit when changed
#var is_alive: bool = true:
	#set(value):
		#if is_alive == value:
			#return
	#
		#is_alive = value
		#is_alive_changed.emit(is_alive)


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
# TODO any better way to assign these values?
# Some variables are player specific, some are enemy specific.
func initilize_stats() -> void:
	# Initilize character stats
	# These are base characteristics.
	# Character specific ones would be under their respective scripts
	if self_id:
		speed_init = Stats.character_stats[self_id]["speed_init"]
		speed_multiplier = Stats.character_stats[self_id]["speed_multiplier"]
		jump_force = Stats.character_stats[self_id]["jump_force"]
		can_ground_jump = Stats.character_stats[self_id]["can_ground_jump"]
		can_air_jump = Stats.character_stats[self_id]["can_air_jump"]
		health_init = Stats.character_stats[self_id]["health_init"]
		knockback_multiplier = Stats.character_stats[self_id]["knockback_multiplier"]
	else:
		print("failed to assign self_id ", self.name)
		return

	# Set starter health and speed
	current_speed = speed_init
	current_health = health_init
	
	#var character_stats: Dictionary = Stats.character_stats[self_id]
	#
	#for key in character_stats.keys():
		#self.key = character_stats[key]
		## Can I use dict key as a variable name somehow?


func apply_damage(_damage_amount):
	damage_label_pop(_damage_amount)
	
	if current_health >= 0:
		current_health = current_health - _damage_amount
		print(self.name, " damage ", _damage_amount, " - ", current_health )
	
	if current_health <= 0:
		if not damageable:
			return
		
		print("Should die: ", self.name)
		_character_death()



# Run upon receiving damage
func damage_label_pop(_damage_amount):
	var pop_scene = Names.DAMAGE_POP_SCENE.instantiate()
	pop_scene.position = Vector2(0, -24)
	pop_scene.damage_amount = _damage_amount
	add_child(pop_scene)


## Apply damage from hurtbox controller
#func apply_damage(_damage_amount):
	##damage_received.emit(_damage_amount)
	#
	#if current_health >= 0:
		#current_health = current_health - _damage_amount
		#print(self.name, " damage ", _damage_amount, " - ", current_health )
	#
	#if current_health <= 0:
		#if not damageable:
			#return
		#
		#print("Should die: ", self.name)
		#_character_death()


func jump_attempt() -> bool:
	if is_on_floor() and can_ground_jump:
		_jump()
		return true
	else:
		return false


func _jump() -> void:
	velocity.y -= jump_force


func _movement_handler(delta) -> void:
	if not is_free:
		return
	
	# Apply gravity
	var gravity: Vector2 = get_gravity()
	velocity.x += gravity.x * delta
	velocity.y += gravity.y * delta

	# Apply movement
	velocity.x = direction.x * current_speed
	move_and_slide()


# TODO Add death animation.
# TODO stop getting damage upon death.
func _character_death() -> void:
	is_alive = false
	print("DIED! ", self.name)
	
	#queue_free()
