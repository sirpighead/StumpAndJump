extends CanvasLayer



var high_score = 0

func _ready() -> void:
	$MainControl/Label.set_text("Lobby High Score: " + str(high_score))

func update_high_score(newScore: int) -> void:
	if newScore > high_score: high_score = newScore
	$MainControl/Label.set_text("Lobby High Score: " + str(high_score))


func start_singleplayer() -> void:
	$MainControl.show()
