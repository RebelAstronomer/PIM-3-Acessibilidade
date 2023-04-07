extends PlayerState

func _enter(msg := {}) -> void:
		# Desabilitando o mouse na tela
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_update(delta: float) -> void:
	# Checando se pode correr
	if Input.is_action_pressed("run") and PLAYER.IS_TIRED == false:
		PLAYER.IS_RUNNING = true
	else:
		PLAYER.IS_RUNNING = false
	
	# Correndo
	if PLAYER.IS_RUNNING == true:
		PLAYER.STAMINA -= 1
		PLAYER.SPEED = PLAYER.SPEED_RUN
		
	else:
		PLAYER.STAMINA += PLAYER.STAMINA_REGEN
		PLAYER.SPEED = PLAYER.SPEED_WALKING
	
	# Se movendo
	PLAYER.player_movimentation(delta)

