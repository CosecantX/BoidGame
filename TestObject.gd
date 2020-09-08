extends StaticBody2D

export var hp = 100

func damage(dmg):
	hp -= dmg
	if hp <= 0:
		queue_free()
