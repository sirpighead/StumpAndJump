extends Node2D

const MAX_PLAYERS = 8

const PLAYER = preload("res://Player/Player.tscn")
const MAIN_MENU = preload("res://MainMenu/MainMenu.tscn")


func _ready() -> void:
#	print("ready")
	pass


func instance_player(player: Object, parent: Object) -> Object:
	return null
