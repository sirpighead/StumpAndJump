extends TileMap

signal missed_next_tile(score)
signal update_counter(steps)
signal change_level(steps)
signal orient_player(direction)

export var startTile = Vector2(3,-1)
var maxR = (startTile.x + 10)
var maxL = (startTile.x - 10)

var curTile
var tileArray
var stepCounter


const RIGHTV = Vector2(1,-3)
const LEFTV = Vector2(-1,-3)


func _ready() -> void:
	randomize()


func place_randomized_tile() -> void:
	var dir = randf()
	var tile = randi() % 4
	
	if dir > .5:
		var newSpot = curTile + RIGHTV
		if newSpot.x < maxR:
			place_tile("r", newSpot, tile)
		else:
			newSpot = curTile + LEFTV
			place_tile("l", newSpot, tile)
	if dir < .5:
		var newSpot = curTile + LEFTV
		if newSpot.x > maxL:
			place_tile("l", newSpot, tile)
		else:
			newSpot = curTile + RIGHTV
			place_tile("r", newSpot, tile)



func place_tile(dir: String, newSpot: Vector2, texture_index: int) -> void:
	set_cellv(newSpot, texture_index)
	tileArray.append(dir)
	curTile = newSpot


func _on_PlayerBody_player_moved(direction: String, _position) -> void:
	place_randomized_tile()
	
	if not direction == tileArray.pop_front():
		emit_signal("missed_next_tile", stepCounter)
	else:
		stepCounter += 1
		emit_signal("update_counter", stepCounter)
		if stepCounter == 100: emit_signal("change_level", stepCounter)


func _on_PlayerBody_restarted(spawn) -> void:
	init_tiles()


func init_tiles():
	curTile = startTile
	stepCounter = 0
	# makes base and 15 random steps at the beginning
	clear()
	for t in 7:
		var tile = randi() % 4
		set_cell(t,-1, tile)
	
	tileArray = []
	for n in 15:
		place_randomized_tile()
	
	emit_signal("orient_player", tileArray.front())
