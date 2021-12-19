extends TileMap

signal missed_next_tile()
signal update_counter(steps)

var curTile
var tileArray = []
var stepCounter = 0

const RIGHTV = Vector2(1,-3)
const LEFTV = Vector2(-1,-3)



func _ready() -> void:
	randomize()
	curTile = Vector2(4,-1)
	
	# makes 25 random steps at the beginning
	for n in 15:
		var dir = randf()
		if dir > .5:
			var newSpot = curTile + RIGHTV
			set_cellv(newSpot, 0)
			curTile = newSpot
			tileArray.append("r")
		if dir < .5:
			var newSpot = curTile + LEFTV
			set_cellv(newSpot, 0)
			curTile = newSpot
			tileArray.append("l")


func _on_player_moved(direction: String, _position) -> void:
	var dir = randf()
	if dir > .5:
		var newSpot = curTile + RIGHTV
		set_cellv(newSpot, 0)
		curTile = newSpot
		tileArray.append("r")
	if dir < .5:
		var newSpot = curTile + LEFTV
		set_cellv(newSpot, 0)
		curTile = newSpot
		tileArray.append("l")
	
	if not direction == tileArray.pop_front():
		emit_signal("missed_next_tile")
	else:
		stepCounter += 1
		emit_signal("update_counter", stepCounter)