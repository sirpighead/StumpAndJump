extends Node2D

const MAX_PLAYERS = 8

const player = preload("res://Player/Player.tscn")
const main_menu = preload("res://MainMenu/MainMenu.tscn")

var peer = null


func _ready() -> void:
#	print("ready")
	var p_instance = player.instance()



func _on_MainMenu_start_singleplayer() -> void:
	print("started singleplayer")
	get_tree().change_scene_to(player)



func _on_MainMenu_host() -> void:
	peer = NetworkedMultiplayerENet.new()
	for n in IP.get_local_addresses().size():
		print(IP.get_local_addresses()[n])
	print(IP.get_local_interfaces())
	get_tree().change_scene_to(player)
