extends Node

var player = null

func set_player(p):
	if p:
		player = p
		print("Player set")
	else:
		print("Error setting player")

func get_player():
	if player:
		return player
	else:
		print("Player not set")
