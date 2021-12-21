extends Actor

signal player_moved(direction, position)
signal show_restart_button
signal restarted(spawn)

const RIGHTV = Vector2(128,-128)
const LEFTV = Vector2(-128,-128)

onready var spawnPoint = position
var falling = false
var started = false


func _input(event: InputEvent) -> void:
	if not falling:
		if event.is_action_pressed("left"):
			if started: emit_signal("player_moved", "l", position + LEFTV)
			position += LEFTV
			
		if event.is_action_pressed("right"):
			if started: emit_signal("player_moved", "r", position + RIGHTV)
			position += RIGHTV
	else:
		emit_signal("show_restart_button")



func _on_TileMap_missed_next_tile() -> void:
	falling = true


func _on_HUD_start_game() -> void:
	started = true
	self.position = spawnPoint


func _on_HUD_restart_game() -> void:
	self.position = spawnPoint
	falling = false
	started = false
	emit_signal("restarted", spawnPoint)
