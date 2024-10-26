extends CharacterBody2D
class_name Player

var speed := 140
var direccion := 0.0
var jump := 250
const gravity := 12

var damage = 1
var canDash = true

@onready var anim := $AnimationPlayer
@onready var sprite := $Sprite2D
@onready var frutaslabel := $PlayerGUI/HBoxContainer/FrutasLabel
@onready var raycastDmg := $RaycastDmg
@onready var dmgColision := $RecibirDanio/CollisionShape2D
@onready var hpbar := $PlayerGUI/VBoxContainer/HPProgressBar
#
#enum estados {NORMAL,HERIDO}
#var estadoActual = estados.NORMAL
@onready var state_machine= $StateMachine

var vida := 3 :
	set(val):
		vida = val
		hpbar.value = vida
var numSaltos = 2

func _ready():
	hpbar.max_value = vida
	hpbar.value = vida
	Global.connect("fruitCollected",actualizaInterfazFrutas)

func _process(delta):
	$LabelState.text = $StateMachine.state.name
	#print($StateMachine.state.name)
	if is_on_floor() and numSaltos != 2 and state_machine.state.name != "enAire":
		reiniciaSalto()
	#Leer los raycast
	for ray in raycastDmg.get_children():
		if ray.is_colliding():
			var colision = ray.get_collider()
			if colision.is_in_group("Enemigos") and colision.has_method("takeDmg"):
				colision.takeDmg(damage)
				state_machine.transition_to("enAire",{Salto = true})
				numSaltos+=1
	if is_on_floor():
		canDash = true
	
func reiniciaSalto():
	numSaltos = 2

func actualizaInterfazFrutas():
	frutaslabel.text = ("x"+str(Global.frutas))
#
func takeDamage(dmg):

	vida-=dmg
	state_machine.transition_to("takeDamage")
	
	if vida <= 0:
		morir()
func morir():
	get_tree().reload_current_scene()


#
#func _physics_process(delta):
#	if estadoActual == estados.NORMAL:
#		procesarNormal(delta)
#
#
#func procesarNormal(delta):
#	direccion = Input.get_axis("ui_left","ui_right")
#	velocity.x = direccion * speed
#
#	if direccion != 0:
#		anim.play("walk")
#	else:
#		anim.play("idle")
#
#	sprite.flip_h = direccion < 0 if direccion != 0 else sprite.flip_h
#
#	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
#		$AudioSalto.play()
#		velocity.y -= jump
#
#	if !is_on_floor():
#		velocity.y += gravity
#
#
#	move_and_slide()
#


#
