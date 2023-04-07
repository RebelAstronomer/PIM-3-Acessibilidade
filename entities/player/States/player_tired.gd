extends PlayerState

func _enter(msg := {}):
	PLAYER.IS_TIRED = true

func _physics_update(delta: float) -> void:
	# Regenerando a stamina
	if PLAYER.IS_TIRED == true:
		PLAYER.STAMINA += PLAYER.STAMINA_REGEN
		if PLAYER.STAMINA >= PLAYER.MAX_STAMINA:
			STATE_MACHINE.change_state("Free")
		else:
			PLAYER.SPEED = PLAYER.SPEED_TIRED
	
	# Se movendo
	PLAYER.player_movimentation(delta)

func _exit():
	PLAYER.IS_TIRED = false
