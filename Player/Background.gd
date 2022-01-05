extends ParallaxBackground

var backgrounds = [
	preload("res://Resources/textures/backgrounds/stage1sky.png"),
	preload("res://Resources/textures/backgrounds/temp_background.png")
]



func next_level():
	$sky/Sky.hide()
	$backclouds.hide()
	$frontclouds.hide()
	$sky/Techno.position = Vector2(0,-(2.5*1280))
	$sky/Techno.show()


func reset():
	$sky/Techno.hide()
	$sky/Techno.position = Vector2(0,-664)
	$sky/Sky.show()
