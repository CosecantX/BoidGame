extends Node

var player = null
var boids = null
var nectar_holder = null
var nectar = 0

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

func set_boids(b):
	if b:
		boids = b
		print("Boids set")
	else:
		print("Error setting boids")

func get_boids():
	if boids:
		return boids
	else:
		print("Boids not set")

func set_nectar_holder(n):
	if n:
		nectar_holder = n
		print("Nectar holder set")
	else:
		print("Error setting nectar holder")

func get_nectar_holder():
	if nectar_holder:
		return nectar_holder
	else:
		print("Nectar holder not set")

func increase_nectar(num):
	nectar += num

func decrease_nectar(num):
	if nectar >= num:
		nectar -= num
		return true
	else:
		return false

func get_nectar():
	return nectar

func attack(obj):
	if player:
		player.attack(obj)
	else:
		print("Player not set")

func change_camera_limit(left, top, right, bottom):
	if player:
		player.change_camera_limit(left, top, right, bottom)
	else:
		print("Player not set")
