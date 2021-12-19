extends Actor

signal player_moved(direction, position)


const RIGHTV = Vector2(128,-128)
const LEFTV = Vector2(-128,-128)

var falling = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left"):
		emit_signal("player_moved", "l", position + LEFTV)
		position += LEFTV
		
	if event.is_action_pressed("right"):
		emit_signal("player_moved", "r", position + RIGHTV)
		position += RIGHTV

