extends Node2D

signal start_game
signal update_highscore(score)


var filepath = "res://Player/keybindings.ini"
var configFile

func _ready() -> void:
	configFile = ConfigFile.new()
	if configFile.load(filepath) == OK:
		for key in configFile.get_section_keys("keybinds"):
			var key_value = configFile.get_value("keybinds", key)
			print(key, " : ", OS.get_scancode_string(key_value))
	else:
		print("configFile not found")
		get_tree().quit()

func _on_TileMap_missed_next_tile(score) -> void:
	emit_signal("update_highscore", score)


func _on_MainHUD_start_game() -> void:
	emit_signal("start_game")
	$PlayerCamera.start_game()
	$MusicPlayer.start_game()
