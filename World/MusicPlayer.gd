extends AudioStreamPlayer

var muted = false
var resumeAt = 0.0

func _on_HUD_start_game() -> void:
	play()


func _on_HUD_restart_game() -> void:
	stop()


func _on_HUD_mute() -> void:
	muted = !muted
	if muted: set_stream_paused(true)
	else: set_stream_paused(false)
