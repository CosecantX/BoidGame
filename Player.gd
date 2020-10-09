extends KinematicBody2D

export var max_move_speed = 500
export var move_speed_multiplier = .5
export var drag = 20
export var bounce_drag = .5
export var min_swipe_dist = 20

var _swipe_start_pos: Vector2
var _swipe_end_pos: Vector2
var _swipe: Vector2
var _velocity = Vector2.ZERO

func _ready():
	Global.set_player(self)

func _physics_process(delta):
	_velocity = _velocity.clamped(max_move_speed)
	var _collision = move_and_collide(_velocity * delta)
	if _collision:
		_velocity = _velocity.bounce(_collision.normal)
		_velocity *= bounce_drag
	_velocity = _velocity.move_toward(Vector2.ZERO, drag * delta)

func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		_swipe_start_pos = get_global_mouse_position()
	if event is InputEventScreenTouch and not event.pressed:
		_swipe_end_pos = get_global_mouse_position()
		var dist = _swipe_start_pos.distance_to(_swipe_end_pos)
		if dist > min_swipe_dist:
			_swipe = _swipe_end_pos - _swipe_start_pos
			var _temp = _swipe * move_speed_multiplier
			_velocity += _temp
#		else:
#			_retrieve_flock()

func _retrieve_flock():
	var flock = Global.get_boids().get_children()
	for f in flock:
		f.retrieve()

func attack(obj):
	var flock = Global.get_boids().get_children()
	for f in flock:
		f.attack(obj)

func change_camera_limit(left, top, right, bottom):
	$Camera2D.limit_left = left
	$Camera2D.limit_top = top
	$Camera2D.limit_right = right
	$Camera2D.limit_bottom = bottom

func _on_Player_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch and event.pressed:
		_retrieve_flock()
