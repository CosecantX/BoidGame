extends Label

export var boid_name = "Bee"

func _process(_delta):
	var _num = Global.get_boids().get_child_count()
	text = str(_num) + " " + boid_name
	if _num != 1:
		text += "s"
