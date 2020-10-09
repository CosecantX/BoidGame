extends Area2D

export var spawn_range = 20

func _on_Nectar_body_entered(body):
	if body.is_in_group("Player"):
		Global.increase_nectar(1)
		queue_free()

func spawn(pos):
	global_position = pos
	global_position.x += rand_range(-spawn_range, spawn_range)
	global_position.y += rand_range(-spawn_range, spawn_range)
