extends Node2D


const PLAYER = preload("res://Player/Player.tscn")

var this_username = "Player"
var player_info = {}


func _ready() -> void:
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_to_server")


func _player_connected(id) -> void:
	print("Player " + str(id) + " has connected")
	
	spawn_player(id, false, this_username)


func _player_disconnected(id) -> void:
	print("Player " + str(id) + " has disconnected")
	
	Main.despawn_player(id)


func _connected_to_server() -> void:
	yield(get_tree().create_timer(0.1), "timeout")
	spawn_player(get_tree().get_network_unique_id(), false, this_username)


func _on_MainMenu_start_singleplayer() -> void:
	spawn_player(1, true, "")
	
	if Players.has_node(str(1)):
		Players.get_node(str(1)).connect("exit_solo_game", self, "_player_disconnected")
	
	hide()


func _on_MainMenu_host(username) -> void:
	print("host game pressed")
	$MainMenu.hide()
	Network.create_server()
	
	this_username = username
	spawn_player(get_tree().get_network_unique_id(), false, this_username)
	hide()


func _on_MainMenu_join(ip, username) -> void:
	print("join game pressed")
	$MainMenu.hide()
	Network.ip_address = ip
	Network.join_server()
	hide()


func spawn_player(id: int, solo: bool, username: String) -> void:
	var player_instance = Main.instance_player(PLAYER, Players, username)
	player_instance.name = str(id)
	if not solo:
		player_instance.set_network_master(id)
