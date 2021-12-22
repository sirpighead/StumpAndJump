extends Node2D


func _on_Player_update_highscore(score) -> void:
	$MainHUD.update_high_score(score)

