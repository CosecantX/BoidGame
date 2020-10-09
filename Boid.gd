extends KinematicBody2D

export var max_speed = 250.0
export var target_follow_force = 0.10
export var cohesion_force = 0.05
export var align_force = 0.05
export var separation_force = 0.05
export var avoid_distance = 20.0
export var bounce_force = 5.0
export var damage = 1
export var spawn_range = 3

onready var hit_timer = $HitTimer

enum {FOLLOWING, ATTACKING}
var _state = FOLLOWING
var _flock = []
var _target
var _velocity

func _ready():
	randomize()
	_velocity = Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized() * max_speed
	_target = self

func _on_FlockView_body_entered(body):
	if self != body and body.is_in_group("Boids"):
		_flock.append(body)

func _on_FlockView_body_exited(body):
	if self != body and body.is_in_group("Boids"):
		_flock.remove(_flock.find(body))

func _physics_process(delta):
	if _state == FOLLOWING:
		_target = Global.get_player()
	if _state == ATTACKING:
		pass
	move_boid(delta)

func move_boid(delta):
	if not _target:
		_state = FOLLOWING
		_target = Global.get_player()
	var target_vector = global_position.direction_to(_target.global_position) * max_speed * target_follow_force
	var vectors = get_flock_status(_flock)
	
	var cohesion_vector = vectors[0] * cohesion_force
	var align_vector = vectors[1] * align_force
	var separation_vector = vectors[2] * separation_force
	
	var acceleration = target_vector + cohesion_vector + align_vector + separation_vector
	_velocity = (_velocity + acceleration).clamped(max_speed)
	rotation = global_position.angle_to(target_vector)
	var _collision = self.move_and_collide(_velocity * delta)
	if _collision:
		if _collision.collider.has_method("damage") and hit_timer.is_stopped():
			_collision.collider.damage(damage)
			hit_timer.start()
		_velocity = _velocity.bounce(_collision.normal)

func get_flock_status(flock):
	var center_vector = Vector2()
	var flock_center = Vector2()
	var align_vector = Vector2()
	var avoid_vector = Vector2()
	
	for f in flock:
		var neighbor_pos = f.global_position
		align_vector += f._velocity
		flock_center += neighbor_pos
		
		var d = global_position.distance_to(neighbor_pos)
		if d > 0 and d < avoid_distance:
			avoid_vector -= (neighbor_pos - global_position).normalized() * (avoid_distance / d * max_speed)
	
	var flock_size = flock.size()
	if flock_size:
		align_vector /= flock_size
		flock_center /= flock_size
		
		var center_dir = global_position.direction_to(flock_center)
		var center_speed = max_speed * (global_position.distance_to(flock_center) / $FlockView/CollisionShape2D.shape.radius)
		center_vector = center_dir * center_speed
	
	return [center_vector, align_vector, avoid_vector]

func attack(obj):
	_state = ATTACKING
	_target = obj

func retrieve():
	_state = FOLLOWING

func spawn(pos):
	global_position = pos
	global_position.x += rand_range(-spawn_range, spawn_range)
	global_position.y += rand_range(-spawn_range, spawn_range)
