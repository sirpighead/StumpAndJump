extends AudioStreamPlayer

var muted = false

const SONGS = [
	preload("res://Resources/music/StumpAndJumpStage1.wav"),
	preload("res://Resources/music/SAJtechnosong.wav"),
	preload("res://Resources/music/SAJredrighthand.wav"),
]


func start_game() -> void:
	play()


func _on_HUD_mute() -> void:
	muted = !muted
	if muted: set_stream_paused(true)
	else: set_stream_paused(false)


func _on_HUD_change_volume(volume) -> void:
	var newVol = int(volume/100.0 * 33) - 50
	if newVol < -49: newVol = -100
	set_volume_db(newVol)


func next_level():
	set_stream(SONGS[1])
#	print("Current music:" + str(stream))
	play(3.0)


func reset(level):
	if level > 1:
		set_stream(SONGS[0])
		play()
