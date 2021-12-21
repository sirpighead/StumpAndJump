extends Node2D
class_name Player

signal player_moved(direction, position)
signal restarted(spawn)
signal switched_direction(dir)

const RIGHTV = Vector2(128,-128)
const LEFTV = Vector2(-128,-128)

onready var playerSprite = get_node("PlayerBody/PlayerSprite")
var spawnPoint
var falling = false
var started = false
var direction
var newPos

func updatePos(newPosition: Vector2) -> void:
	$PlayerBody.set_position(newPosition)
	position = newPosition

func set_spawnPoint(spawnPoint: Vector2) -> void:
	self.spawnPoint = spawnPoint

func set_started(started: bool)->void:
	self.started = started

func set_falling(falling: bool)->void:
	self.falling = falling

func set_direction(direction: String)->void:
	self.direction = direction

func set_newPos(newPos: Vector2)->void:
	self.newPos = newPos


func _unhandled_input(event: InputEvent) -> void:
	if not falling:
		if started and event.is_action_pressed("left"):
			if direction == "l": 
				print("node sL(pos):" + str(position))
				print("KB2D sL(pos):" + str($PlayerBody.position))
				direction = "r"
				newPos = position + RIGHTV
				print("newpos SL:" + str(newPos))
				emit_signal("player_moved", direction, newPos)
				position = newPos
				
				playerSprite.set_flip_h(false)
				
				print("node(final pos sL):" + str(position) + "\n")
				print("KB2D(final pos sL):" + str($PlayerBody.position) + "\n")
			
			else: 
				print("node(pos sR):" + str(position))
				print("KB2D(pos sR):" + str($PlayerBody.position))
				direction = "l"
				newPos = position + LEFTV
				print("newpos sR:" + str(newPos))
				emit_signal("player_moved", direction, newPos)
				position = newPos
				
				playerSprite.set_flip_h(true)
				
				print("node(final pos sR):" + str(position) + "\n")
				print("KB2D(final pos sR):" + str($PlayerBody.position) + "\n")
			
			emit_signal("switched_direction", direction)
		
		elif started and event.is_action_pressed("right"):
			
			print("node(pos a):" + str(position))

			if direction == "l": newPos = position + LEFTV
			else: newPos = position + RIGHTV
			print("newpos a:" + str(newPos))
			emit_signal("player_moved", direction, newPos)
			position = newPos
			
			print("advance(newpos&pos):" + str(position) + "\n")
			print("KB2D(final pos a):" + str($PlayerBody.position) + "\n")
		


func _on_TileMap_missed_next_tile() -> void:
	falling = true


func _on_PlayerHUD_restart_game() -> void:
	emit_signal("restarted", self.spawnPoint)
	falling = false
	started = false
	print("restart prev pos:" + str(position))
	updatePos(self.spawnPoint)
	print("restart final pos:" + str(position) + "\n")


func _on_World_init_player(spawn) -> void:
	print("initplayer(node pos):" + str(position))
	print("initplayer(body pos):" + str($PlayerBody.position))
	playerSprite.set_flip_h(false)
	self.started = true
	updatePos(spawn)
	spawnPoint = position
	print("spawnPoint:" + str(spawnPoint))
	direction = "r"
	newPos = position + RIGHTV
	print("initplayer(node pos(should be spawn)):" + str(position))
	print("initplayer(body pos(should be spawn)):" + str($PlayerBody.position))
	print("initplayer(newpos):" + str(newPos) + "\n")
