extends Actor

signal player_moved(direction, position)

signal restarted(spawn)
signal switched_direction(dir)

const RIGHTV = Vector2(128,-128)
const LEFTV = Vector2(-128,-128)

export var spawnPoint = Vector2(448,-112)
var falling = false
var started = false
var direction
var newPos

#network variables
puppet var puppet_position = Vector2(0,0) setget puppet_position_set
puppet var puppet_direction = ""


func _unhandled_input(event: InputEvent) -> void:
	if get_tree().get_network_peer() == null or is_network_master():
		if not falling:
			if started and event.is_action_pressed("switch"):
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
				

			
			elif started and event.is_action_pressed("advance"):
				if direction == "l": newPos = position + LEFTV
				else: newPos = position + RIGHTV
				emit_signal("player_moved", direction, newPos)
				position = newPos
				


func puppet_position_set(newPos: Vector2) -> void:
	puppet_position = newPos


func _on_Network_tick_rate_timeout() -> void:
	if is_network_master():
		rset_unreliable("puppet_position", position)
		rset_unreliable("puppet_direction", direction)



func start_game() -> void:
	started = true
	self.position = spawnPoint


func _on_TileMap_missed_next_tile(_score) -> void:
	falling = true


func _on_HUD_restart_game() -> void:
	self.position = spawnPoint
	falling = false
	$Sprite.set_flip_h(false)
	emit_signal("restarted", spawnPoint)


func _on_TileMap_orient_player(direction) -> void:
	self.direction = direction
	if self.direction == "r": 
		$Sprite.set_flip_h(false)
		newPos = position + RIGHTV
	else: 
		$Sprite.set_flip_h(true)
		newPos = position + LEFTV
