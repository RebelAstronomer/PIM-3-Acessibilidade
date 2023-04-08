extends PlayerState

func _enter(msg := {}):
	# Declarando que está cansado
	PLAYER.IS_TIRED = true
	PLAYER.IS_RUNNING = false
	
	# Resetando a velocidade
	PLAYER.SPEED = PLAYER.SPEED_TIRED

func _physics_update(delta: float) -> void:
	# Checando se ainda está cansado
	if PLAYER.IS_TIRED == true:
		
		# Regenerando a stamina
		PLAYER.STAMINA += PLAYER.STAMINA_REGEN
		PLAYER.SPEED = PLAYER.SPEED_TIRED
		
		# Se stamina estiver cheia volte ao estado Free
		if PLAYER.STAMINA >= PLAYER.MAX_STAMINA:
			PLAYER.IS_TIRED = false
			STATE_MACHINE.change_state("Free")
	
	# Se movendo
	PLAYER.player_movimentation(delta)
