extends Node2D

signal update_highscore(score)
signal exit_solo_game(id)

var game_mode = ""
export var spawnPoint = Vector2(448,-112)
var high_score = 0
var level = 0

const LEVELS = [
	preload("res://SinglePlayerWorld/Level1.tscn"),
	preload("res://SinglePlayerWorld/Level2.tscn"),
]

var currentLevel = 0


func init_player() -> void:
	print("player " + name + " loaded")
	if not get_tree().get_network_peer() == null:
		if is_network_master() and name == "1":
			start_host_game()
		elif is_network_master():
			start_client_game()
		else:
			start_puppet_game()
			
	else:
		start_solo_game()
	print("game mode: " + game_mode)
	print()
	


func start_solo_game() -> void:
	print("started singleplayer")
	game_mode = "solo"
	
	currentLevel = LEVELS[level].instance()
	add_child(currentLevel)
	
	$PlayerCamera._set_current(true)
	$HUD.start_game(game_mode)
	
	$TileMap.init_tiles()
	$PlayerBody.start_game(game_mode)
	$PlayerBody/Username.hide()
	$PlayerCamera.start_game()
	$MusicPlayer.start_game()


func start_host_game() -> void:
	print("Server created!")
	game_mode = "host"

	$PlayerCamera._set_current(true)


	$HUD.start_game(game_mode)
	$TileMap.init_tiles()
	$PlayerBody.start_game(game_mode)
	$PlayerCamera.start_game()
	$MusicPlayer.start_game()


func start_client_game() -> void:
	print("Client Created!")
	print()
	game_mode = "client"

	$PlayerCamera._set_current(true)
	$HUD.start_game(game_mode)
	$TileMap.init_tiles()
	$PlayerBody.start_game(game_mode)
	$PlayerCamera.start_game()
	$MusicPlayer.start_game()


func start_puppet_game():
	print("Puppet Created!")
	print()
	game_mode = "puppet"
	
	$PlayerBody.start_game(game_mode)



func _on_HUD_exit_game() -> void:
	print("exiting game mode " + game_mode)
	$MusicPlayer.stop()
	if game_mode == "solo":
		emit_signal("exit_solo_game", int(self.name))
	elif is_network_master():
		Main.network_disconnect()
	
	get_tree().change_scene("res://Lobby.tscn")



func _on_HUD_update_highscore(score) -> void:
	high_score = score
	emit_signal("update_highscore", high_score) #replace this with networked version rpc or sum




func _on_TileMap_reached_100_steps(steps) -> void:
#	print("prev level" + str(level))
	if level < 1:
		level += 1
#		print("leveled up: " + str(level))
		
#		print("current level path: " + currentLevel.get_path())
#		print("current level: " + str(get_child(get_children().size() - 1)))
		get_child(get_children().size() - 1).queue_free()
		
		currentLevel = LEVELS[level].instance()
#		print("current level path: " + currentLevel.get_path())
#		print("current level: " + str(currentLevel))
		add_child(currentLevel)
		
		var playerPos = $PlayerBody.position
		$MusicPlayer.next_level()
		$PlayerBody.next_level(playerPos)
		$PlayerCamera.next_level()
		
#		print("Player children: " + str(get_children()))


func _on_PlayerBody_restarted(spawn, lvl) -> void:
	self.level = 0
	
	get_child(get_children().size() - 1).queue_free()
	currentLevel = LEVELS[level].instance()
	add_child(currentLevel)
	
	$TileMap.reset(spawn)
	$PlayerCamera.reset(spawn)
	$HUD.reset(spawn)
	$MusicPlayer.reset(lvl)
