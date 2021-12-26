extends Node2D

const MAX_PLAYERS = 8

const PLAYER = preload("res://Player/Player.tscn")
const MAIN_MENU = preload("res://MainMenu/MainMenu.tscn")

const PORT = 6969

var peer = null
var players = {}


func _ready() -> void:
#	print("ready")
	pass



func _on_MainMenu_start_singleplayer() -> void:
	print("started singleplayer")
	get_tree().get_root().add_child(PLAYER.instance())
	hide()



func _on_MainMenu_host() -> void:
	peer = NetworkedMultiplayerENet.new()
	peer.create_server(PORT, MAX_PLAYERS)
	get_tree().network_peer = peer
	
	var instance = PLAYER.instance()
	get_tree().get_root().add_child(instance)
	hide()


func _on_MainMenu_join(net_info) -> void:
	peer = NetworkedMultiplayerENet.new()
	peer.create_client(net_info[0], net_info[1])
	var unique_id = peer.get_unique_id()
	var username = "otherPlayer"
	players[unique_id] = username
	
	get_tree().network_peer = peer
	
	get_tree().get_root().add_child(PLAYER.instance())
	hide()
