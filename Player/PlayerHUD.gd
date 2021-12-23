extends CanvasLayer

signal restart_game
signal mute
signal change_volume(volume)

var settings_showing

func _ready() -> void:
	$RestartButton.hide()
	$EndMessage.hide()
	$Settings.hide()

func _on_TileMap_update_counter(steps) -> void:
	$MoveCounter.set_text(str(steps))


func _on_TileMap_missed_next_tile(_score) -> void:
	$EndMessage.show()
	$RestartButton.show()



func _on_RestartButton_pressed() -> void:
	$EndMessage.hide()
	$MoveCounter.set_text("0")
	emit_signal("restart_game")


func _on_Player2_restarted(spawn) -> void:
	$RestartButton.hide()


func _on_Player2_switched_direction(dir) -> void:
	$Direction.set_text(dir.to_upper())


func _on_MuteButton_pressed() -> void:
	emit_signal("mute")


func _on_TileMap_orient_player(direction) -> void:
	$Direction.set_text(direction.to_upper())


func _on_TextureButton_pressed() -> void:
	settings_showing = !settings_showing
	
	if settings_showing: 
		$Settings.show()
	else: 
		$Settings.hide()


func _on_VolumeSlider_value_changed(value: float) -> void:
	emit_signal("change_volume", value)
	
	$Settings/VolumeRow/VolumeLabel.set_text("Volume: " + str(int(value)))
