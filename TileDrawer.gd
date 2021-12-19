extends TileMap

var curTile

const RIGHTV = Vector2(1,-2)
const LEFTV = Vector2(-1,-2)



func _ready() -> void:
	randomize()
	curTile = Vector2(4,-1)
	
	# makes 25 random steps at the beginning
	for n in 25:
		var dir = randf()
		if dir > .5:
			var newSpot = curTile + RIGHTV
			set_cellv(newSpot, 0)
			curTile = newSpot
		if dir < .5:
			var newSpot = curTile + LEFTV
			set_cellv(newSpot, 0)
			curTile = newSpot


func _on_player_moved(direction: String):
	var dir = randf()
	if dir > .5:
		var newSpot = curTile + RIGHTV
		set_cellv(newSpot, 0)
		curTile = newSpot
	if dir < .5:
		var newSpot = curTile + LEFTV
		set_cellv(newSpot, 0)
		curTile = newSpot
