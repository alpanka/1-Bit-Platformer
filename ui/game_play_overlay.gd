class_name GamePlayOverlay
extends Control

@onready var health_label: Label = $VBoxContainer/Health/HealthLabel
@onready var kill_count_label: Label = $VBoxContainer/Kills/KillCountLabel


var health: int
var kill_count: int


func _ready() -> void:
	_initialize_onverlay()


func _initialize_onverlay():
	# Connect to used signals
	Signals.player_health_changed.connect(_on_health_changed)
	Signals.enemy_died.connect(_on_enemy_died)
	
	# Update label.text
	_update_ui_labels()


func _update_ui_labels():
	health_label.text = str(health)
	kill_count_label.text = str(kill_count)


func _on_health_changed(_currenth_health: int, _damage: int):
	health = _currenth_health - _damage
	_update_ui_labels()


func _on_enemy_died(_enemy_name: String):
	kill_count += 1
	_update_ui_labels()
