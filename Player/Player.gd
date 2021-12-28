extends Node2D

signal start_game
signal update_highscore(score)

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


func start_solo_game() -> void:
	$PlayerCamera._set_current(true)
	$HUD.start_game(game_mode)
	$PlayerBody.start_game()
	$PlayerBody/Username.set_text("")
	$PlayerCamera.start_game()
	$MusicPlayer.start_game()


func start_host_game() -> void:
	print("Server created!")
	game_mode = "host"

	$PlayerCamera._set_current(true)
	$HUD.start_game(game_mode)
	$PlayerBody.start_game()
	$PlayerCamera.start_game()
	$MusicPlayer.start_game()


func start_client_game() -> void:
	print("Client Created!")
	game_mode = "client"

	$PlayerCamera._set_current(true)
	$HUD.start_game(game_mode)
	$PlayerBody.start_game()
	$PlayerCamera.start_game()
	$MusicPlayer.start_game()


func _on_HUD_exit_game() -> void:
	$MusicPlayer.stop()
	get_tree().change_scene("res://Lobby.tscn")



func _on_HUD_update_highscore(score) -> void:
	high_score = score
	emit_signal("update_highscore", high_score) #replace this with networked version rpc or sum

