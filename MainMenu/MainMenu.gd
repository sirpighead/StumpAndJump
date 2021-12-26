extends Control

signal start_singleplayer
signal host
signal join(net_info)

var network_info = []
var main_node

func _ready() -> void:
#	print("menu loaded")
	$HostLobby.hide()
	$JoinScreen.hide()
	$TitleScreen.show()


func _on_HostButton_pressed() -> void:
	$TitleScreen.hide()
	$HostLobby.show()


func _on_SoloButton_pressed() -> void:
	emit_signal("start_singleplayer")
	hide()


func _on_BackButton_pressed() -> void:
	$HostLobby.hide()
	$JoinScreen.hide()
	$TitleScreen.show()
	network_info.clear()


func _on_JoinButton_pressed() -> void:
	print(IP.get_local_addresses())
	$TitleScreen.hide()
	$JoinScreen/JoinGameButton.set_flat(true)
	$JoinScreen.show()


func _on_JoinScreen_netInfoFilled(net_info) -> void:
	$JoinScreen/JoinGameButton.set_flat(false)
	$JoinScreen/JoinGameButton.set_text("Join Game!")
	network_info = net_info


func _on_HostGameButton_pressed() -> void:
	emit_signal("host")
	hide()


func _on_JoinGameButton_pressed() -> void:
	emit_signal("join", network_info)
	hide()
