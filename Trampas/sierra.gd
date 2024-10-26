@tool
extends Node2D
var dmg = 1

@onready var sprite = $Path2D/PathFollow2D/SierraVerdadera/Sprite
@onready var path = $Path2D/PathFollow2D

@export var platformSpeed : float = .2
var isRight = true

func _process(delta):
	sprite.rotate(deg_to_rad(450*delta))
	
	#sierra.global_position = path.global_position
	if isRight:
		path.progress_ratio += platformSpeed * delta
	else :
		path.progress_ratio -= platformSpeed * delta
	
	if path.progress_ratio >= .95:
		isRight = false
	elif path.progress_ratio <= .05:
		isRight = true

