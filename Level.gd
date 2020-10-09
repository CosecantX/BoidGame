extends Node2D

onready var sprite = $test_map

func _ready():
	var rect = sprite.get_rect()
	var left = 0
	var top = 0
	var right = rect.size.x
	var bottom = rect.size.y
	Global.change_camera_limit(left, top, right, bottom)
