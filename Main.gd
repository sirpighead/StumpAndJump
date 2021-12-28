extends Node2D


func instance_player(node: Object, parent: Object, username = "Player") -> Object:
	var p_inst = node.instance()
	parent.add_child(p_inst)
	return p_inst


func despawn_player(id) -> void:
	if Players.has_node(str(id)):
		Players.get_node(str(id)).queue_free()


func despawn_all_players() -> void:
	Players.children = []
