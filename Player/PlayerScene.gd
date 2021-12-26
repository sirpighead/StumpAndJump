extends Node2D

signal start_game
signal update_highscore(score)

var game_mode = ""
export var spawnPoint = Vector2(448,-112)
var high_score = 0


func _ready() -> void:
#	print("player loaded")
	start_singleplayer()


func start_singleplayer() -> void:
	game_mode = "solo"
	$PlayerCamera._set_current(true)
	$HUD.start_game()
	$PlayerBody.start_game()
	$PlayerCamera.start_game()
	$MusicPlayer.start_game()


func _on_HUD_exit_game() -> void:
	$MusicPlayer.stop()
	get_tree().change_scene("res://Main.tscn")



func _on_HUD_update_highscore(score) -> void:
	high_score = score
	emit_signal("update_highscore", high_score) #replace this with networked version
