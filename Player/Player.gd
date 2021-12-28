extends Node2D


signal update_highscore(score)
signal exit_game

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
	print("started singleplayer")
	$PlayerCamera._set_current(true)
	$HUD.start_game(game_mode)
	$PlayerBody.start_game()
	$PlayerBody/Username.hide()
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
	if game_mode == "solo":
		$Players.get_node(str(1)).queue_free()
		get_node("res://Lobby.tscn").show()
	else:
		emit_signal("p_disconnected", get_tree().get_network_unique_id())


func _on_HUD_update_highscore(score) -> void:
	high_score = score
	emit_signal("update_highscore", high_score) #replace this with networked version rpc or sum

