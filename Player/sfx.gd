extends Node2D

func _ready() -> void:
	randomize()


func play(sfx = null):
	if !sfx: 
		var sound = randi()%get_child_count()
		get_child(sound).play()
	else: 
		get_node(sfx).play()


func _on_PlayerBody_player_moved(direction, position) -> void:
	play()
