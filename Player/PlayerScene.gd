extends Node2D

signal start_game
signal update_highscore(score)
signal exit_game(game_mode)

var game_mode = ""
export var spawnPoint = Vector2(448,-112)


func _ready() -> void:
	hide()


func _on_TileMap_missed_next_tile(score) -> void:
	emit_signal("update_highscore", score)


func _on_MainHUD_start_game() -> void:
	emit_signal("start_game")
	


func start_singleplayer() -> void:
	game_mode = "solo"
	show()
	$PlayerCamera._set_current(true)
	$HUD.start_game()
	$PlayerBody.start_game()
	$PlayerCamera.start_game()
	$MusicPlayer.start_game()


func _on_HUD_exit_game() -> void:
	$MusicPlayer.stop()
	emit_signal("exit_game", game_mode)
