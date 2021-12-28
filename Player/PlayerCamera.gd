extends Camera2D

var falling = false

func _on_TileMap_missed_next_tile(_score) -> void:
	falling = true

func _on_PlayerBody_player_moved(_direction, position) -> void:
	if not falling:
		self.position = position


func _on_PlayerBody_restarted(spawn) -> void:
	set_v_drag_enabled(false)
	set_h_drag_enabled(false)
	falling = false
	set_enable_follow_smoothing(false)
	self.position = spawn
	set_enable_follow_smoothing(true)
	


func start_game() -> void:
	print("player camera started")
	set_v_drag_enabled(true)
	set_h_drag_enabled(true)
