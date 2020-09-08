extends ProgressBar

func _ready():
	max_value = $"../".hp

func _process(_delta):
	value = $"../".hp
