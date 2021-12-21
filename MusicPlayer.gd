extends AudioStreamPlayer


func _on_HUD_start_game() -> void:
	play()


func _on_HUD_restart_game() -> void:
	stop()
