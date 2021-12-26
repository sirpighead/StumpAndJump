extends Node2D

const MAX_PLAYERS = 8

const PLAYER = preload("res://Player/Player.tscn")
const MAIN_MENU = preload("res://MainMenu/MainMenu.tscn")

const PORT = 6969

var peer = null


func _ready() -> void:
#	print("ready")
	var p_instance = PLAYER.instance()



func _on_MainMenu_start_singleplayer() -> void:
	print("started singleplayer")
	get_tree().change_scene_to(PLAYER)



func _on_MainMenu_host() -> void:
	peer = NetworkedMultiplayerENet.new()
	peer.create_server(PORT, MAX_PLAYERS)
	get_tree().network_peer = peer
	
	get_tree().change_scene_to(PLAYER)


func _on_MainMenu_join(net_info) -> void:
	peer = NetworkedMultiplayerENet.new()
	peer.create_client(net_info[0], net_info[1])
	get_tree().network_peer = peer
	
	get_tree().change_scene_to(PLAYER)
