extends CanvasLayer

signal restart_game
signal mute
signal change_volume(volume)
signal exit_game
signal update_highscore(score)

var settings_showing
var high_score = 0


func _ready() -> void:
	$Control.hide()


func start_game(mode):
	$Control/RestartButton.hide()
	$Control/EndMessage.hide()
	$Control/Settings/Controlpanel.hide()
	$Control/Settings.hide()
	
	if mode == "host":
		$Control/ServerInfo.set_text("Hosting Server at " + Network.ip_address)
	elif mode == "client":
		$Control/ServerInfo.set_text("Joined Game at " + Network.ip_address)
	elif mode == "solo":
		$Control/ServerInfo.set_text("Singleplayer mode")
	else:
		$Control/ServerInfo.set_text("How are you seeing this???")

	$Control.show()


func _on_TileMap_update_counter(steps) -> void:
	$Control/MoveCounter.set_text(str(steps))


func _on_TileMap_missed_next_tile(score) -> void:
	if score > high_score: 
		high_score = score
		$Control/HighScoreLabel.set_text("Lobby High Score: " + str(high_score))
		emit_signal("update_highscore", high_score) #replace this with networked version
	$Control/EndMessage.show()
	$Control/RestartButton.show()



func _on_RestartButton_pressed() -> void:
	$Control/EndMessage.hide()
	$Control/MoveCounter.set_text("0")
	emit_signal("restart_game")


func _on_PlayerBody_restarted(spawn) -> void:
	$Control/RestartButton.hide()


func _on_PlayerBody_switched_direction(dir) -> void:
	$Control/Direction.set_text(dir.to_upper())


func _on_MuteButton_pressed() -> void:
	emit_signal("mute")


func _on_TileMap_orient_player(direction) -> void:
	$Control/Direction.set_text(direction.to_upper())


func _on_TextureButton_pressed() -> void:
	settings_showing = !settings_showing
	
	if settings_showing: 
		$Control/Settings.show()
	else: 
		if $Control/Settings/Controlpanel.is_visible_in_tree():
			$Control/Settings/Controlpanel.hide()
		$Control/Settings.hide()


func _on_VolumeSlider_value_changed(value: float) -> void:
	emit_signal("change_volume", value)
	
	$Control/Settings/VolumeRow/VolumeLabel.set_text("Volume: " + str(int(value)))


func _on_XButton_pressed() -> void:
#	emit_signal("restart_game")
	if $Control/Settings/Controlpanel.is_visible_in_tree():
		$Control/Settings/Controlpanel.hide()
	$Control.hide()
	emit_signal("exit_game")


func _on_ShowInputs_pressed() -> void:
	if !$Control/Settings/Controlpanel.is_visible_in_tree():
		$Control/Settings/Controlpanel.show()
	else:
		$Control/Settings/Controlpanel.hide()
