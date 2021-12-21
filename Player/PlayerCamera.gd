extends Camera2D

var falling = false

func _on_TileMap_missed_next_tile(_score) -> void:
	falling = true

func _on_Player2_player_moved(_direction, position) -> void:
	if not falling:
		self.position = position


func _on_Player2_restarted(spawn) -> void:
	set_v_drag_enabled(false)
	set_h_drag_enabled(false)
	falling = false
	self.position = spawn
	


func _on_HUD_start_game() -> void:
	set_v_drag_enabled(true)
	set_h_drag_enabled(true)
