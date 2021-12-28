extends Node2D


var id = ""


func _ready() -> void:
	Network.connect("p_connected", self, "_set_id")
	Network.connect("p_disconnected", self, "_dc_ed")
	Network.connect("con_to_serv", self, "_connected_to_server")


func _on_MainMenu_start_singleplayer() -> void:
	print("main menu start singleplayer")
	spawn_player(1)
	hide()


func _on_MainMenu_host(username) -> void:
	print("host game pressed")
	Network.create_server()
	$MainMenu/HostLobby/DefaultPort.set_text(str(Network.DEFAULT_PORT))
	
	spawn_player(get_tree().get_network_unique_id())
	hide()


func _on_MainMenu_join(ip, username) -> void:
	print("join game pressed")
	Network.ip_address = ip
	Network.join_server()
	
	spawn_player(id)
	hide()


func _set_id(id) -> void:
	self.id = id
#	print(self.id)


func _dc_ed(id) -> void:
	if $Players.has_node(str(id)):
		$Players.get_node(str(id)).queue_free()


func _connected_to_server() -> void:
	yield(get_tree().create_timer(0.1), "timeout")
	spawn_player(get_tree().get_network_unique_id())


func spawn_player(id) -> void:
	print("spawn player: " + str(id))
	var player = Main.instance_player($Players)
	player.name = str(id)
	if not get_tree().get_network_peer() == null:
		player.set_network_master(id)
