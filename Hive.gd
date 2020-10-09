extends StaticBody2D

var boid_scene = preload("res://Boid.tscn")

export var nectar_cost = 1

var _player_present = false

func _on_Hive_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch and event.pressed and _player_present:
		if Global.decrease_nectar(nectar_cost):
			var b = boid_scene.instance()
			Global.get_boids().add_child(b)
			b.spawn(global_position)

func _on_Player_Detector_body_entered(body):
	if body.is_in_group("Player"):
		_player_present = true

func _on_Player_Detector_body_exited(body):
	if body.is_in_group("Player"):
		_player_present = false
