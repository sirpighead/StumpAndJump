extends Control

signal start_singleplayer

func _ready() -> void:
	$HostLobby.hide()


func _on_HostButton_pressed() -> void:
	$TitleScreen.hide()
	$HostLobby.show()


func _on_SoloButton_pressed() -> void:
	emit_signal("start_singleplayer")
	hide()


func _on_BackButton_pressed() -> void:
	$HostLobby.hide()
	$TitleScreen.show()
