extends CanvasLayer

func _on_TileMap_update_counter(steps) -> void:
	$MoveCounter.set_text(str(steps))
