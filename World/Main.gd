extends Node2D


func _on_MainHUD_start_game() -> void:
	$Player/PlayerBody.start_game()


func _on_Player_update_highscore(score) -> void:
	$MainHUD.update_high_score(score)

