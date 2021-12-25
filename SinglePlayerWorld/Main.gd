extends Node2D


func _on_MainHUD_start_game() -> void:
	$Player/PlayerBody.start_game()


func _on_Player_update_highscore(score) -> void:
	$LobbyHUD.update_high_score(score)


func _on_MainMenu_start_singleplayer() -> void:
	$Player.start_singleplayer()
	$LobbyHUD.start_singleplayer()


func _on_Player_exit_game(game_mode) -> void:
	$MainCamera._set_current(true)
	if game_mode == "solo":
		$LobbyHUD/MainControl.hide()
		$Player.hide()
		$MainMenu.show()
	else:
		print("game_mode reference not found")
