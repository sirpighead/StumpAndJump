extends Node2D

signal start_game
signal update_highscore(score)

var game_mode = ""
export var spawnPoint = Vector2(448,-112)
var high_score = 0


func _ready() -> void:
#	print("player loaded")
	if not get_tree().get_network_peer() == null:
		var this_peer = get_tree().network_peer
		if get_tree().is_network_server():
			print("Server created!")
			game_mode = "hosting"
		else:
			print("Client Created!")
			print(Main.players)
			game_mode = "connecting"
	
	start_game()


func start_game() -> void:
	$PlayerCamera._set_current(true)
	$HUD.start_game()
	$PlayerBody.start_game()
	$PlayerCamera.start_game()
	$MusicPlayer.start_game()


func _on_HUD_exit_game() -> void:
	$MusicPlayer.stop()
	if not get_tree().get_network_peer() == null:
		get_tree().network_peer.close_connection()
		get_tree().network_peer = null
	get_tree().change_scene("res://Main.tscn")



func _on_HUD_update_highscore(score) -> void:
	high_score = score
	emit_signal("update_highscore", high_score) #replace this with networked version
