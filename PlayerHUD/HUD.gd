extends CanvasLayer

signal start_game
signal restart_game
signal mute

func _ready() -> void:
	$RestartButton.hide()
	$EndMessage.hide()

func _on_TileMap_update_counter(steps) -> void:
	$MoveCounter.set_text(str(steps))


func _on_TileMap_missed_next_tile() -> void:
	$EndMessage.show()
	$RestartButton.show()


func _on_StartGame_pressed() -> void:
	$StartGame.hide()
	emit_signal("start_game")


func _on_RestartButton_pressed() -> void:
	$StartGame.show()
	$EndMessage.hide()
	$MoveCounter.set_text("0")
	$Direction.set_text("R")
	emit_signal("restart_game")


func _on_Player2_restarted(spawn) -> void:
	$RestartButton.hide()


func _on_Player2_switched_direction(dir) -> void:
	$Direction.set_text(dir.to_upper())


func _on_MuteButton_pressed() -> void:
	emit_signal("mute")
