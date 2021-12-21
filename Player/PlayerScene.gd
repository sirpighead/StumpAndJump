extends Node2D

signal start_game
signal update_highscore(score)


func _on_TileMap_missed_next_tile(score) -> void:
	emit_signal("update_highscore", score)


func _on_MainHUD_start_game() -> void:
	emit_signal("start_game")
	$PlayerCamera.start_game()
	$MusicPlayer.start_game()
