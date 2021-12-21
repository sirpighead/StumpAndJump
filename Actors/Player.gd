extends Actor

signal player_moved(direction, position)
signal show_restart_button
signal restarted(spawn)
signal switched_direction(dir)

const RIGHTV = Vector2(128,-128)
const LEFTV = Vector2(-128,-128)

onready var spawnPoint = position
var falling = false
var started = false
var direction
var newPos


func _input(event: InputEvent) -> void:
	if not falling:
		if started and event.is_action_pressed("left"):
			if direction == "l": 
				direction = "r"
				newPos = position + RIGHTV
				emit_signal("player_moved", direction, newPos)
				position = newPos
				
				$Sprite.set_flip_h(false)
			
			else: 
				direction = "l"
				newPos = position + LEFTV
				emit_signal("player_moved", direction, newPos)
				position = newPos
				
				$Sprite.set_flip_h(true)
			
			emit_signal("switched_direction", direction)
		
		elif started and event.is_action_pressed("right"):
			if direction == "l": newPos = position + LEFTV
			else: newPos = position + RIGHTV
			emit_signal("player_moved", direction, newPos)
			position = newPos
		



func _on_TileMap_missed_next_tile() -> void:
	falling = true


func _on_HUD_start_game() -> void:
	started = true
	self.position = spawnPoint
	direction = "r"
	newPos = position + RIGHTV


func _on_HUD_restart_game() -> void:
	self.position = spawnPoint
	falling = false
	started = false
	emit_signal("restarted", spawnPoint)
