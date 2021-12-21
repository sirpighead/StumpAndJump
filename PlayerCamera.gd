extends Camera2D

var falling = false

func _on_TileMap_missed_next_tile() -> void:
	falling = true

func _on_Player_player_moved(_direction, pos) -> void:
	if not falling:
		self.position = pos
	print("camera:" + str(self.position))


func _on_Player_restarted(spawn) -> void:
	set_v_drag_enabled(false)
	set_h_drag_enabled(false)
	falling = false
	self.position = spawn


func _on_PlayerHUD_start_game() -> void:
	set_v_drag_enabled(true)
	set_h_drag_enabled(true)
