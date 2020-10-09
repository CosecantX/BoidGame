extends "res://TestObject.gd"

var hive = preload("res://Hive.tscn")

func die():
	if _alive:
		_alive = false
		var h = hive.instance()
		Global.get_nectar_holder().add_child(h)
		h.global_position = global_position
		queue_free()
