extends Node2D



func _on_Player_start_game() -> void:
	pass # Replace with function body.


func _on_Player_update_highscore(score) -> void:
	$MainHUD.update_high_score(score)
