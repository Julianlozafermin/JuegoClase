extends Node

const SAVEFILE = "user://SAVEFILE.save"

var game_data = {
	"NUMERO" : 12,
	"NivelDelJugador" : 0,
	"ArmasDelJugador" : 12,
	"HPMAX" : 100,
	"NUEVO_VALOR" : 100
}

func _ready():
	load_data()
	print(game_data)

func load_data():
	var file = FileAccess.open(SAVEFILE,FileAccess.READ)
	print(file)
	if file == null:
		save_data()
	else:
		game_data = file.get_var()
	save_data()
	file = null 

func save_data():
	var file = FileAccess.open(SAVEFILE,FileAccess.WRITE)
	file.store_var(game_data)
	file = null 



