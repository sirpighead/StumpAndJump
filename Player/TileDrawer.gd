extends TileMap

signal missed_next_tile(score)
signal update_counter(steps)
signal orient_player(direction)

var curTile
var tileArray
var stepCounter

const RIGHTV = Vector2(1,-3)
const LEFTV = Vector2(-1,-3)


func _ready() -> void:
	randomize()
	curTile = Vector2(3,-1)
	stepCounter = 0
	
	# makes 25 random steps at the beginning
	tileArray = []
	for n in 15:
		var dir = randf()
		var tile = randi() % 4 + 5
		if dir > .5:
			var newSpot = curTile + RIGHTV
			set_cellv(newSpot, tile)
			curTile = newSpot
			tileArray.append("r")
		if dir < .5:
			var newSpot = curTile + LEFTV
			set_cellv(newSpot, tile)
			curTile = newSpot
			tileArray.append("l")
	
	emit_signal("orient_player", tileArray.front())


func _on_player_moved(direction: String, _position) -> void:
	var dir = randf()
	var tile = randi() % 4 + 5
	if dir > .5:
		var newSpot = curTile + RIGHTV
		set_cellv(newSpot, tile)
		curTile = newSpot
		tileArray.append("r")
	if dir < .5:
		var newSpot = curTile + LEFTV
		set_cellv(newSpot, tile)
		curTile = newSpot
		tileArray.append("l")
	
	if not direction == tileArray.pop_front():
		emit_signal("missed_next_tile", stepCounter)
	else:
		stepCounter += 1
		emit_signal("update_counter", stepCounter)


func _on_Player2_restarted(spawn) -> void:
	clear()
	for t in 7:
		set_cell(t,-1, 0)
	_ready()
