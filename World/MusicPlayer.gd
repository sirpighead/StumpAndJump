extends AudioStreamPlayer

var muted = false
export var startAt = 4.5


func start_game() -> void:
	play(startAt)


func _on_HUD_mute() -> void:
	muted = !muted
	if muted: set_stream_paused(true)
	else: set_stream_paused(false)
