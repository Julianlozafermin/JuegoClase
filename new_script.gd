extends Node

var numero

func _ready():
	numero = Savedos.game_data.NUMERO
	$Label.text = str(numero)

func _on_button_pressed():
	numero+=1
	Savedos.game_data.NUMERO = numero
	Savedos.save_data()
	$Label.text = str(numero)
