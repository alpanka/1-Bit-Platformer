extends Node


# Player specific signals
signal player_died
signal player_health_changed(current_health: int, damage_amount: int)


signal enemy_died(enemy_name: String)
