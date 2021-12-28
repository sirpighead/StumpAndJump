extends Node2D

signal update_highscore(score)
signal exit_solo_game(id)

var game_mode = ""
export var spawnPoint = Vector2(448,-112)
var high_score = 0


func _ready() -> void:
#	print("player loaded")
	if not get_tree().get_network_peer() == null:
		if get_tree().is_network_server():
			start_host_game()
		else:
			start_client_game()
			
	else:
		start_solo_game()
	
	print("game mode: " + game_mode)


func start_solo_game() -> void:
	print("started singleplayer")
	game_mode = "solo"
	$PlayerCamera._set_current(true)
	$HUD.start_game(game_mode)
	$PlayerBody.start_game(game_mode)
	$PlayerBody/Username.hide()
	$PlayerCamera.start_game()
	$MusicPlayer.start_game()


func start_host_game() -> void:
	print("Server created!")
	print()
	game_mode = "host"

	$PlayerCamera._set_current(true)
	$HUD.start_game(game_mode)
	$PlayerBody.start_game(game_mode)
	$PlayerCamera.start_game()
	$MusicPlayer.start_game()


func start_client_game() -> void:
	print("Client Created!")
	print()
	game_mode = "client"

	$PlayerCamera._set_current(true)
	$HUD.start_game(game_mode)
	$PlayerBody.start_game(game_mode)
	$PlayerCamera.start_game()
	$MusicPlayer.start_game()


func _on_HUD_exit_game() -> void:
	print("exiting game mode " + game_mode)
	$MusicPlayer.stop()
	if game_mode == "solo":
		emit_signal("exit_solo_game", int(self.name))
	else:
		Main.network_disconnect()
	
	get_tree().change_scene("res://Lobby.tscn")



func _on_HUD_update_highscore(score) -> void:
	high_score = score
	emit_signal("update_highscore", high_score) #replace this with networked version rpc or sum

