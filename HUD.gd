extends CanvasLayer

signal start_game
signal restart_game

func _ready() -> void:
	$RestartButton.hide()

func _on_TileMap_update_counter(steps) -> void:
	$MoveCounter.set_text(str(steps))


func _on_TileMap_missed_next_tile() -> void:
	$MoveCounter.set_text("Take the L Bozo")


func _on_StartGame_pressed() -> void:
	$StartGame.hide()
	emit_signal("start_game")


func _on_Player2_show_restart_button() -> void:
	$RestartButton.show()
	

func _on_RestartButton_pressed() -> void:
	$StartGame.show()
	$MoveCounter.set_text("0")
	emit_signal("restart_game")


func _on_Player2_restarted(spawn) -> void:
	$RestartButton.hide()
