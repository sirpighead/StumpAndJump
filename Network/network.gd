extends Node

signal p_connected(id)
signal p_disconnected(id)
signal con_to_serv


const DEFAULT_PORT = 6969
const MAX_PLAYERS = 8

var server
var client

var ip_address = ""


func _ready() -> void:
	if OS.get_name() == "Windows":
		ip_address = IP.get_local_addresses()[1]
	elif OS.get_name() == "Android":
		ip_address = IP.get_local_addresses()[0]
	else:
		ip_address = IP.get_local_addresses()[3]
	
	for ip in IP.get_local_addresses():
		if ip.begins_with("192.168.") and not ip.ends_with(".1"):
			ip_address = ip
	
#	print(IP.get_local_addresses())
#	print(ip_address)
	
	#client signals
	get_tree().connect("connected_to_server", self, "_connected_to_server")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	get_tree().connect("connection_failed", self, "_connection_failed")
	
	#server/client signals 
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")


func create_server() -> void:
	print("create server called")
	
	server = NetworkedMultiplayerENet.new()
	server.create_server(DEFAULT_PORT, MAX_PLAYERS)
	
#	print(server)
	get_tree().set_network_peer(server)
	
#	print(get_tree().get_network_unique_id())


func join_server() -> void:
	print("join server called")
	client = NetworkedMultiplayerENet.new()
	client.create_client(ip_address, DEFAULT_PORT)
	get_tree().set_network_peer(client)
	
#	print(get_tree().get_network_unique_id())


func _player_connected(id) -> void:
	print("Player " + str(id) + " has connected")
	emit_signal("p_connected", id)


func _player_disconnected(id) -> void:
	print("Player " + str(id) + " has disconnected")
	emit_signal("p_disconnected", id)


func _connected_to_server() -> void:
	print("Successfully connected to the server")
	emit_signal("con_to_serv")


func _server_disconnected() -> void:
	print("Disconnected from the server")


func _connection_failed() -> void:
	print("Could not connect to server")
