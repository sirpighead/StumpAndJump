extends CanvasLayer

var high_score = 0

func _ready() -> void:
	$Control/Label.set_text("Lobby High Score: " + str(high_score))

func update_high_score(newScore: int) -> void:
	if newScore > high_score: high_score = newScore
	$Control/Label.set_text("Lobby High Score: " + str(high_score))
