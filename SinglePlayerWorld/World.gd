extends Node2D

signal orient_player(direction)
signal update_counter(steps)
signal missed_next_tile(score)


func start_world():
	$TileMap.init_tiles()
	$MusicPlayer.start_game()


func _on_PlayerBody_player_moved(direction: String, _position) -> void:
	$TileMap.update_tilemap(direction)


func _on_PlayerBody_restarted(spawn) -> void:
	$TileMap.init_tiles()


func _on_TileMap_missed_next_tile(score) -> void:
	emit_signal("missed_next_tile", score)


func _on_TileMap_orient_player(direction) -> void:
	emit_signal("orient_player", direction)


func _on_TileMap_update_counter(steps) -> void:
	emit_signal("update_counter", steps)
