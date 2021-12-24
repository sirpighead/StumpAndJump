extends AudioStreamPlayer

var muted = false
export var startAt = 4.5


func start_game() -> void:
	play(startAt)


func _on_HUD_mute() -> void:
	muted = !muted
	if muted: set_stream_paused(true)
	else: set_stream_paused(false)


func _on_HUD_change_volume(volume) -> void:
	var newVol = int(volume/100.0 * 33) - 50
	if newVol < -49: newVol = -100
	set_volume_db(newVol)
