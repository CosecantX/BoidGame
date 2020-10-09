extends StaticBody2D

export var max_hp = 10
export var nectar_spawn = 3

var hp = max_hp
var _alive = true

var nectar_scene = preload("res://Nectar.tscn")

func _physics_process(_delta):
	if hp == max_hp:
		$HealthBar.visible = false
	else:
		$HealthBar.visible = true

func damage(dmg):
	hp -= dmg
	if hp <= 0:
		die()

func _on_TestObject_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch and event.pressed:
		Global.attack(self)

func die():
	if _alive:
		_alive = false
		for _i in nectar_spawn:
			var n = nectar_scene.instance()
			Global.get_nectar_holder().add_child(n)
			n.spawn(global_position)
		queue_free()
