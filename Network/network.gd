extends Node

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
		if ip.begins_with("192.168."):
			ip_address = ip
	
#	print(IP.get_local_addresses())
#	print(ip_address)
	
	#client signals
	get_tree().connect("connected_to_server", self, "_connected_to_server")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	get_tree().connect("connection_failed", self, "_connection_failed")


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


func _connected_to_server() -> void:
	print("Successfully connected to the server")


func _server_disconnected() -> void:
	print("Disconnected from the server")


func _connection_failed() -> void:
	print("Could not connect to server")
