extends PlayerState

var canChangeState = false
var direccion : float

var wallJumpVertical = 350
var wallJumpHorizontal = 180


func state_enter_state(msg := {}):
	canChangeState = false
	direccion = Input.get_axis("ui_left","ui_right")
	$"../../AudioSalto".play()
	anim_player.play("jumpCaer")
	#player.velocity = Vector2.ZERO
func state_physics_process(delta):

	player.velocity.y = lerpf(player.velocity.y,-wallJumpVertical,.8 )
	player.velocity.x = lerpf(player.velocity.x, -direccion * wallJumpHorizontal,.8)
	
#	print(player.velocity.y," contra ",-wallJumpVertical)
#	print(player.velocity.x, "contra ",wallJumpHorizontal)
	#Completo el wall jump
	if player.velocity.y <= -wallJumpVertical or player.is_on_ceiling():
		canChangeState = true
		#print("puedo cambiar estado")
	player.move_and_slide()
	
	if canChangeState and !player.is_on_floor():
		state_machine.transition_to("enAire")
	elif Input.is_action_just_pressed("dash"):
		state_machine.transition_to("Dash")
	
