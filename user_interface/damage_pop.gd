extends Control

@onready var damage_label: Label = $DamageLabel
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var scene_lifetime: float = 0.1
var damage_amount: int

func _ready() -> void:
	damage_label.text = str(damage_amount)
	
	timer.wait_time = scene_lifetime
	timer.start()


func _on_timer_timeout() -> void:
	animation_player.play("label_pop")
	
	# Attempt with tweening. Turned it into AnimationPlayer
	#var tween: Tween = get_tree().create_tween().set_parallel(true)
	#tween.tween_property(damage_label, "position", position - Vector2(100, 0), 0.15)
	#tween.tween_property(damage_label, "scale", scale * 10, 0.15)
	#tween.tween_property(damage_label, "self_modulate", Color(1, 1, 1, 0.1), 0.5)
	#tween.tween_callback(queue_free)
