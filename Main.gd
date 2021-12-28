extends Node2D


func instance_player(node: Object, parent: Object, username = "Player") -> Object:
	var p_inst = node.instance()
	p_inst.get_node("./PlayerBody/Username").set_text(username)
	parent.add_child(p_inst)
	return p_inst


func despawn_player(id) -> void:
	if Players.has_node(str(id)):
		Players.get_node(str(id)).queue_free()


func despawn_all_players() -> void:
	for p in Players.get_children():
		p.queue_free()


func network_disconnect() -> void:
	despawn_all_players()
	get_tree().network_peer.close_connection()
	get_tree().network_peer = null
	
