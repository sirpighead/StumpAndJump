extends Control

signal start_singleplayer
signal host(username)
signal join(net_info, username)

var ip = ""
var username = "Player"

func _ready() -> void:
#	print("menu loaded")
	$HostLobby.hide()
	$JoinScreen.hide()
	$TitleScreen.show()
	
	get_tree().connect("connection_failed", self, "_on_connection_failed")


func _on_HostButton_pressed() -> void:
	$TitleScreen.hide()
	$HostLobby/DefaultPort.hide()
	$HostLobby/UsernameInput.hide()
	$HostLobby/CreateServer.set_disabled(true)
	$HostLobby/CreateServer.hide()
	
	$HostLobby.show()


func _on_SoloButton_pressed() -> void:
	emit_signal("start_singleplayer")
	hide()


func _on_BackButton_pressed() -> void:
	$HostLobby.hide()
	$JoinScreen.hide()
	$TitleScreen.show()
	ip = ""


func _on_JoinButton_pressed() -> void:
#	print(IP.get_local_addresses())
	$TitleScreen.hide()
	$JoinScreen/ConnectButton.set_disabled(true)
	$JoinScreen/ResetButton.hide()
	$JoinScreen.show()


func _on_JoinScreen_netInfoFilled(net_info) -> void:
	$JoinScreen/ConnectButton.set_disabled(false)
	$JoinScreen/ConnectButton.set_text("Join Game!")
	ip = net_info


func _on_HostGameButton_pressed() -> void:
	$HostLobby/DefaultPort.show()
	$HostLobby/UsernameInput.show()
	$HostLobby/CreateServer.show()
	$HostLobby/DefaultPort.set_text("Default Port: " + str(Network.DEFAULT_PORT))


func _on_ConnectButton_pressed() -> void:
	emit_signal("join", ip, username)
	hide()


func _on_connection_failed() -> void:
	$JoinScreen/ResetButton.show()
	$JoinScreen/ConnectButton.set_text("Connection Failed!")


func _on_CreateServer_pressed() -> void:
	emit_signal("host", username)
	hide()


func _on_UsernameInput_text_entered(new_text: String) -> void:
	$HostLobby/CreateServer.set_disabled(false)
	username = new_text


func _on_Client_Username_text_entered(new_text: String) -> void:
	username = new_text


func _on_ResetButton_pressed() -> void:
	$JoinScreen/Client_Username.clear()
	$JoinScreen/IPInput.clear()
	$JoinScreen/ConnectButton.set_text("Enter Server Info")
	$JoinScreen/ConnectButton.set_disabled(true)
	$JoinScreen/ResetButton.hide()
