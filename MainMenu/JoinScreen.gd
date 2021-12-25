extends Control

signal netInfoFilled(net_info)

var network_info = []


func _on_BackButton_pressed() -> void:
	network_info.clear()
	$IPInput.clear()
	$PortInput.clear()


func _on_PortInput_text_entered(new_text: String) -> void:
	if network_info.size() == 1: 
		network_info.append(new_text)
		emit_signal("netInfoFilled", network_info)


func _on_IPInput_text_entered(new_text: String) -> void:
	if network_info.size() == 0: network_info.append(new_text)
