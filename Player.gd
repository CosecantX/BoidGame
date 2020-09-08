extends KinematicBody2D

export var max_move_speed = 500
export var move_speed_multiplier = .5
export var drag = 20
export var bounce_drag = 50
export var min_swipe_dist = 20

var _swipe_start_pos: Vector2
var _swipe_end_pos: Vector2
var _swipe: Vector2
var _velocity = Vector2.ZERO
var _flock = []

func _ready():
	Global.set_player(self)

func _physics_process(delta):
	_velocity = _velocity.clamped(max_move_speed)
	var _collision = move_and_collide(_velocity * delta)
	if _collision:
		if _collision.collider.is_in_group("Targets"):
			_attack(_collision.collider)
		_velocity = _velocity.bounce(_collision.normal)
		_velocity = _velocity.move_toward(Vector2.ZERO, bounce_drag)
	_velocity = _velocity.move_toward(Vector2.ZERO, drag * delta)

func _input(event):
	if event.is_action_pressed('click'):
		_swipe_start_pos = get_global_mouse_position()
	if event.is_action_released("click"):
		_swipe_end_pos = get_global_mouse_position()
		var dist = _swipe_start_pos.distance_to(_swipe_end_pos)
		if dist > min_swipe_dist:
			_swipe = _swipe_end_pos - _swipe_start_pos
			var _temp = _swipe * move_speed_multiplier
			_velocity += _temp
		else:
			_retrieve_flock()

func _retrieve_flock():
	for f in _flock:
		f.retrieve()

func _attack(obj):
	for f in _flock:
		f.attack(obj)

func _on_BoidDetector_body_entered(body):
	if body.has_method("activate"):
		body.activate()
		_flock.append(body)
