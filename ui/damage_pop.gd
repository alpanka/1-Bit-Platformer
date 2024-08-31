extends Control

@onready var damage_label: Label = $DamageLabel
@onready var timer: Timer = $Timer

var scene_lifetime: float = 1.5
var damage_amount: int

func _ready() -> void:
	damage_label.text = str(damage_amount)
	
	timer.wait_time = scene_lifetime
	timer.start()


func _on_timer_timeout() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(damage_label, "self_modulate", Color(1, 1, 1, 0.1), 0.15)
	tween.tween_callback(queue_free)
