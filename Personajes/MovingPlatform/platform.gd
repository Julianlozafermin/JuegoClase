@tool
extends Path2D

@export var platformSpeed : float = .2
var isRight = true
func _process(delta):
	#if Engine.is_editor_hint(): #Corre en el editor
	#if not Engine.is_editor_hint(): #Solo en el juego
		
	#$PlatformCharacter.global_position = $PathFollow2D.global_position
	if isRight:
		$PathFollow2D.progress_ratio += platformSpeed * delta
	else :
		$PathFollow2D.progress_ratio -= platformSpeed * delta
	
	if $PathFollow2D.progress_ratio >= .95:
		isRight = false
	elif $PathFollow2D.progress_ratio <= .05:
		isRight = true
