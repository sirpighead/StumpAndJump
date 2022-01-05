extends Control

signal netInfoFilled(ip)

var target_ip = ""


func _ready() -> void:
	$JoinLobby.hide()
	$HostLobby.hide()


func _on_BackButton_pressed() -> void:
	target_ip = ""
	$IPInput.clear()


func _on_IPInput_text_entered(new_text: String) -> void:
	target_ip = new_text
	emit_signal("netInfoFilled", target_ip)


func _on_Host_pressed() -> void:
	$HostLobby.show()


func _on_Join_pressed() -> void:
	$JoinLobby.show()
