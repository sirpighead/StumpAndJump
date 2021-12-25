extends Control

signal start_singleplayer

var network_info = []

func _ready() -> void:
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
	$TitleScreen.hide()
	$JoinScreen/JoinGameButton.set_flat(true)
	$JoinScreen.show()


func _on_JoinScreen_netInfoFilled(net_info) -> void:
	$JoinScreen/JoinGameButton.set_flat(false)
	network_info = net_info
