extends Control

signal start_singleplayer
signal host(username)
signal join(net_info, username)

var ip = ""
var username = "Player"

func _ready() -> void:
#	print("menu loaded")
	$MPLobby.hide()
	$TitleScreen.show()
	
	get_tree().connect("connection_failed", self, "_on_connection_failed")


func _on_HostButton_pressed() -> void:
	$TitleScreen.hide()
	$MPLobby/HostLobby/DefaultPort.hide()
	$MPLobby/HostLobby/UsernameInput.hide()
	$MPLobby/HostLobby/CreateServer.set_disabled(true)
	$MPLobby/HostLobby/CreateServer.hide()
	
	$MPLobby/HostLobby.show()


func _on_SoloButton_pressed() -> void:
	emit_signal("start_singleplayer")
	hide()


func _on_BackButton_pressed() -> void:
	$MPLobby/HostLobby.hide()
	$MPLobby/JoinLobby.hide()
	$MPLobby.hide()
	$SingleplayerLobby.hide()
	$TitleScreen.show()
	ip = ""


func _on_JoinButton_pressed() -> void:
#	print(IP.get_local_addresses())
	$TitleScreen.hide()
	$MPLobby/JoinLobby/ConnectButton.set_disabled(true)
	$MPLobby/JoinLobby/ResetButton.hide()
	$MPLobby/JoinLobby.show()


func _on_JoinScreen_netInfoFilled(net_info) -> void:
	$MPLobby/JoinLobby/ConnectButton.set_disabled(false)
	$MPLobby/JoinLobby/ConnectButton.set_text("Join Game!")
	ip = net_info


func _on_HostGameButton_pressed() -> void:
	$MPLobby/HostLobby/DefaultPort.show()
	$MPLobby/HostLobby/UsernameInput.show()
	$MPLobby/HostLobby/CreateServer.show()
	$MPLobby/HostLobby/DefaultPort.set_text("Default Port: " + str(Network.DEFAULT_PORT))


func _on_ConnectButton_pressed() -> void:
	emit_signal("join", ip, username)
	hide()


func _on_connection_failed() -> void:
	$MPLobby/JoinLobby/ResetButton.show()
	$MPLobby/JoinLobby/ConnectButton.set_text("Connection Failed!")


func _on_CreateServer_pressed() -> void:
	emit_signal("host", username)
	hide()


func _on_UsernameInput_text_entered(new_text: String) -> void:
	$MPLobby/HostLobby/CreateServer.set_disabled(false)
	username = new_text


func _on_Client_Username_text_entered(new_text: String) -> void:
	username = new_text


func _on_ResetButton_pressed() -> void:
	$MPLobby/JoinLobby/Client_Username.clear()
	$MPLobby/JoinLobby/IPInput.clear()
	$MPLobby/JoinLobby/ConnectButton.set_text("Enter Server Info")
	$MPLobby/JoinLobby/ConnectButton.set_disabled(true)
	$MPLobby/JoinLobby/ResetButton.hide()
