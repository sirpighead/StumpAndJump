extends Node2D

const MAX_PLAYERS = 8

const PLAYER = preload("res://Player/Player.tscn")

onready var DEFAULT_PARENT = get_tree().get_root()


func _ready() -> void:
	pass


func instance_player_at_spawn(parent = DEFAULT_PARENT, username = "Player") -> Object:
	var p_inst = PLAYER.instance()
	p_inst.get_node("PlayerBody/Username").set_text(username)
	parent.add_child(p_inst)
	return p_inst


func instance_player(parent = DEFAULT_PARENT, username = "Player") -> Object:
	var p_inst = PLAYER.instance()
	
	p_inst.get_node("PlayerBody/Username").set_text(username)
	
	print("instanced player " + str(p_inst) + " to")
	print("parent: " + str(parent))
	parent.add_child(p_inst)
	print("children: ", parent.get_children())
	
	return p_inst


