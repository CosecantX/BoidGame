extends Label

export var nectar_name = "Nectar Drop"

func _process(_delta):
	var _num = Global.get_nectar()
	text = str(_num) + " " + nectar_name
	if _num != 1:
		text += "s"
