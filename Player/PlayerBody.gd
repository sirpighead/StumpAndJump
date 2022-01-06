extends KinematicBody2D

signal player_moved(direction, position)

signal restarted(spawn, level)
signal switched_direction(dir)

const RIGHTV = Vector2(128,-128)
const LEFTV = Vector2(-128,-128)

var game_mode = ""

export var spawnPoint = Vector2(448,-112)
var falling = false
var started = false
var direction
var newPos
var level

#physics variables
export var speed = Vector2(300.0,1000.0)
export var gravity = 2.0
var velocity: = Vector2.ZERO


#network variables
puppet var puppet_position = Vector2(0,0) setget puppet_position_set
puppet var puppet_direction = "l" setget puppet_direction_set


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	velocity.y += gravity*delta
	velocity.y = max(velocity.y, speed.y)
	
	velocity = move_and_slide(velocity)


func _unhandled_input(event: InputEvent) -> void:
	
	if  game_mode == "solo" or is_network_master():
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


func puppet_position_set(new_value) -> void:
	puppet_position = new_value
	
	position = puppet_position


func puppet_direction_set(new_value) -> void:
	puppet_direction = new_value
	
	direction = puppet_direction


func _on_Network_tick_rate_timeout() -> void:
	if is_network_master():
		rset_unreliable("puppet_position", position)
		rset_unreliable("puppet_direction", direction)


func start_game(gm) -> void:
	game_mode = gm
	started = true
	self.position = spawnPoint
	level = 1
	if not game_mode == "solo": $Network_tick_rate.start()
	if game_mode == "puppet":
		set_physics_process(false)
		print("Turns puppet gravity to " + str(gravity))


func _on_TileMap_missed_next_tile(_score) -> void:
	falling = true
	if not game_mode == "solo" or not game_mode == "puppet":
		rpc("set_physicis_process", true)


func _on_HUD_restart_game() -> void:
	self.position = spawnPoint
	falling = false
	$Sprite.set_flip_h(false)
	if not game_mode == "puppet": 
		emit_signal("restarted", spawnPoint, level)
	
	level = 1


func _on_TileMap_orient_player(direction) -> void:
	self.direction = direction
	if self.direction == "r": 
		$Sprite.set_flip_h(false)
		newPos = position + RIGHTV
	else: 
		$Sprite.set_flip_h(true)
		newPos = position + LEFTV


func next_level(pos):
	level += 1
	print("level advanced to " + str(level))
