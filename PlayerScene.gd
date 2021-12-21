extends Node2D

signal player_moved(direction, position)
signal restarted(spawn)
signal switched_direction(dir)

const RIGHTV = Vector2(128,-128)
const LEFTV = Vector2(-128,-128)

var spawnPoint
var falling = false
var started = false
var direction
var newPos

func _unhandled_input(event: InputEvent) -> void:
	if not falling:
		if started and event.is_action_pressed("left"):
			if direction == "l": 
				direction = "r"
				newPos = position + RIGHTV
				emit_signal("player_moved", direction, newPos)
				position = newPos
				
				$PlayerSprite.set_flip_h(false)
			
			else: 
				direction = "l"
				newPos = position + LEFTV
				emit_signal("player_moved", direction, newPos)
				position = newPos
				
				$PlayerSprite.set_flip_h(true)
			
			emit_signal("switched_direction", direction)
		
		elif started and event.is_action_pressed("right"):
			if direction == "l": newPos = position + LEFTV
			else: newPos = position + RIGHTV
			emit_signal("player_moved", direction, newPos)
			position = newPos

#func _on_TileMap_missed_next_tile() -> void:
#	$Player.missed_next_tile()
#
#
#func _on_PlayerHUD_restart_game() -> void:
#	$Player.restart_player()
#
#
#func _on_World_init_player(spawnPoint) -> void:
#	$Player.world_init_player(spawnPoint)
#
#
#func _on_Player_player_moved(direction, position) -> void:
#	pass # Replace with function body.
#
#
#func _on_Player_restarted(spawn) -> void:
#	pass # Replace with function body.
#
#
#func _on_Player_switched_direction(dir) -> void:
#	pass # Replace with function body.
