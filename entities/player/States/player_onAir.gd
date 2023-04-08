extends PlayerState

func _enter(msg := {}) -> void:
	PLAYER.VELOCITY.y = PLAYER.JUMP_FORCE 

func _physics_update(delta : float) -> void:
	# Se movendo
	PLAYER.player_movimentation(delta)
	
	if PLAYER.is_on_floor():
		if PLAYER.IS_TIRED == false:
			STATE_MACHINE.change_state("Free")
		else:
			STATE_MACHINE.change_state("Tired")
