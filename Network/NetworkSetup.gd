extends Node2D


func _ready() -> void:
	pass


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
