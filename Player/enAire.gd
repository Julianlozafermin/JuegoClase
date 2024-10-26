extends PlayerState

var hasJumped = false
var isFalling = false



func state_enter_state(msg := {}):
	hasJumped = false
	player.velocity = Vector2.ZERO
	if msg.has("Salto"):
		hasJumped = true
		player.numSaltos -= 1
		$"../../AudioSalto".play()
		anim_player.play("jump")
		player.velocity.y = -player.jump
		#print(player.numSaltos)
		print(player.numSaltos)
		if player.numSaltos == 0:
			anim_player.play("jumpDoble")
	else:
		anim_player.play("jumpCaer")
	
	if isFalling : 
		$CoyoteTimer.start()



func state_physics_process(delta):
	
	
	var direccion = Input.get_axis("ui_left","ui_right")
#
	player.sprite.flip_h = direccion < 0  if direccion != 0 else player.sprite.flip_h 

	player.velocity.x = direccion * player.speed

	if player.velocity.y > 0:
		isFalling = true
	else:
		isFalling = false
	
	player.velocity.y += player.gravity 
	
	player.move_and_slide()

	
	if player.is_on_wall():
		state_machine.transition_to("wallSlide")
	
	if player.is_on_floor():
		state_machine.transition_to("Idle")
	
	if !$BufferJumpTimer.is_stopped() and player.is_on_floor():
		$BufferJumpTimer.stop()
		#print("SaltoJumpBuffer")
		player.reiniciaSalto()
		state_machine.transition_to("enAire",{Salto = true})
	#Entrada doble salto
	elif hasJumped and Input.is_action_just_pressed("ui_accept") and player.numSaltos > 0:
		state_machine.transition_to("enAire",{Salto = true})
	elif  !$CoyoteTimer.is_stopped() and Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("enAire",{Salto = true})
	elif Input.is_action_just_pressed("ui_accept"):
		$BufferJumpTimer.start()
	elif Input.is_action_just_pressed("dash") and player.canDash:
		state_machine.transition_to("Dash")

func state_exit():
	pass 
