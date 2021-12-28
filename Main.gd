extends Node2D

const MAX_PLAYERS = 8

const PLAYER = preload("res://Player/Player.tscn")
const MAIN_MENU = preload("res://MainMenu/MainMenu.tscn")


func _ready() -> void:
#	print("ready")
	pass


func instance_player_at_spawn(parent: Object, username: String) -> Object:
	var p_inst = PLAYER.instance()
	p_inst.get_node("PlayerBody/Username").set_text(username)
	parent.add_child(p_inst)
	return p_inst


func instance_player(parent: Object, username: String) -> Object:
	var p_inst = PLAYER.instance()
	p_inst.get_node("PlayerBody/Username").set_text(username)
	parent.add_child(p_inst)
	return p_inst
