extends Line2D

var _start_point = Vector2.ZERO

func _process(_delta):
	if Input.is_action_pressed("click"):
		clear_points()
		add_point(_start_point)
		add_point(get_global_mouse_position())
	else:
		clear_points()

func _input(event):
	if event.is_action_pressed("click"):
		_start_point = get_global_mouse_position()

