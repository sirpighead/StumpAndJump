extends AudioStreamPlayer

var muted = false
var pausingPoint

func _on_PlayerHUD_start_game() -> void:
	pausingPoint = 0.0
	if not muted: play()


func _on_PlayerHUD_restart_game() -> void:
	if not muted: stop()


func _on_PlayerHUD_toggle_mute() -> void:
	muted = !muted
	if muted: 
		pausingPoint = get_playback_position()
		stop()
	else: 
		play(pausingPoint)

