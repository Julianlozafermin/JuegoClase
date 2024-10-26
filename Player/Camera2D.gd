extends Camera2D

@export var cancelVerticalFollow = false
@export var inicioY = 50


func _ready():
	if cancelVerticalFollow:
		top_level = true
		global_position.y = inicioY

func _process(delta):
	if cancelVerticalFollow:
		global_position.x = get_parent().global_position.x
	
