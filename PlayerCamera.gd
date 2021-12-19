extends Camera2D

var falling = false

#func _on_TileMap_missed_next_tile() -> void:
#	falling = true


func _on_Player2_player_moved(_direction, position) -> void:
	if not falling:
		self.position = position
