extends Node2D

signal start_game
signal update_highscore(score)

func _on_HUD_start_game() -> void:
	emit_signal("start_game")


func _on_TileMap_missed_next_tile(score) -> void:
	emit_signal("update_highscore", score)
