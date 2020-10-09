extends Line2D

var _start_point = Vector2.ZERO

func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		_start_point = event.position
	elif event is InputEventScreenDrag:
		clear_points()
		add_point(_start_point)
		add_point(event.position)
	elif event is InputEventScreenTouch and not event.pressed:
		clear_points()

