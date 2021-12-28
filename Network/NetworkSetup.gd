extends Node2D


func _ready() -> void:
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_to_server")


func _player_connected(id) -> void:
	print("Player " + str(id) + " has connected")


func _player_disconnected(id) -> void:
	print("Player " + str(id) + " has disconnected")



func _on_MainMenu_start_singleplayer() -> void:
	print("started singleplayer")
	get_tree().change_scene_to(Main.PLAYER)
	hide()


func _on_MainMenu_host(username) -> void:
	print("host game pressed")
	Network.create_server()
	$MainMenu/HostLobby/DefaultPort.set_text(str(Network.DEFAULT_PORT))
	
	Main.instance_player(get_tree().get_root(), username)
	hide()


func _on_MainMenu_join(ip, username) -> void:
	print("join game pressed")
	Network.ip_address = ip
	Network.join_server()
	
	Main.instance_player(get_tree().get_root(), username)
	hide()
