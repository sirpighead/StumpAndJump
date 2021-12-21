extends Node2D

signal init_player(spawn)

const spawn = Vector2(448,-112)


func _on_PlayerHUD_start_game() -> void:
	emit_signal("init_player", spawn)
