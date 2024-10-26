extends Area2D

signal heHechoDanio

@export var danio = 1
func _on_area_entered(area):
	if area.is_in_group("AreaPlayer"):
		print("Danio")
		area.owner.takeDamage(danio)
		emit_signal("heHechoDanio")
