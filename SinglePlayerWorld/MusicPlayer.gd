extends AudioStreamPlayer

var muted = false
var correct_volume = -25

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
	correct_volume = int(volume/100.0 * 33) - 50
	if correct_volume < -49: correct_volume = -100
	set_volume_db(correct_volume)


func next_level():
	fade_out()
	
	set_stream(SONGS[1])
#	print("Current music:" + str(stream))
	play(4.5)
	fade_in()


func fade_out():
	$MusicTween.interpolate_property(self, "volume_db", correct_volume, -80, \
	1.0, 1, Tween.EASE_IN, 0)
	$MusicTween.start()


func fade_in():
	$MusicTween.interpolate_property(self, "volume_db", -80, correct_volume, \
	1.0, 1, Tween.EASE_IN, 0)
	$MusicTween.start()


func reset(level):
	if level > 1:
		set_stream(SONGS[0])
		play()
