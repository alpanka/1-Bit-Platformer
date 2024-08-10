##
## Base class for all paltformer characters
##
class_name PlatformerCharacterBase
extends CharacterBody2D

## Emit direction change
signal direction_changed(direction: Vector2)
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


#enum STATE {
	#IDLE 	= 0,
	#WALK 	= 1,
	#RUN 	= 2,
	#JUMP	= 3,
	#ATTACK 	= 10,
	#DAMAGED	= 11,
	#DEATH 	= 20
#}
#
## State change setter, emitter
#var current_state: STATE:
	#set(new_state):
		#if current_state == new_state:
			#return
#
		#state_changed.emit(current_state, new_state)
		#current_state = new_state


func _ready() -> void:
	# Apply stats. Using self_id from _init() on instances
	initilize_stats()
	#current_state = STATE.IDLE

func _physics_process(delta: float) -> void:
	velocity.x = direction.x * speed
	
	_apply_gravity(delta)
	#_movement_checker()
	move_and_slide()

# Initilize character specific stats
func initilize_stats() -> void:
	if self_id:
		speed = Stats.character_stats[self_id]["speed"]
		jump_force = Stats.character_stats[self_id]["jump_force"]
		can_ground_jump = Stats.character_stats[self_id]["can_ground_jump"]
		can_air_jump = Stats.character_stats[self_id]["can_air_jump"]
		health_init = Stats.character_stats[self_id]["health_init"]
	else:
		print("failed self_id", self)
		return

	current_health = health_init


# Apply damage from hurtbox controller
func apply_damage(_damage_amount):
	if current_health >= 0:
		#current_state = STATE.DAMAGED
		current_health = current_health - _damage_amount
		print("damage on ", _damage_amount, " ", self)
	
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
	#current_state = STATE.JUMP


func _apply_gravity(delta) -> void:
	var gravity: Vector2 = get_gravity()
	velocity.x += gravity.x * delta
	velocity.y += gravity.y * delta


#func _movement_checker():
	#if not is_zero_approx(direction.x):
		#current_state = STATE.RUN
	#else:
		#current_state = STATE.IDLE

# TODO State doesnt stick on death.
# TODO Add death animation.
func _character_death() -> void:
	#current_state = STATE.DEATH
	print("DIED! ", self)
	
	queue_free()
