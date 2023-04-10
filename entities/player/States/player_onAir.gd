extends PlayerState

func _enter(msg := {}) -> void:
	PLAYER.ACT_STATE = self.name
	PLAYER.VELOCITY.y = PLAYER.JUMP_FORCE 

func _handle_input(_event: InputEvent) -> void:
	PLAYER.player_mouse_input(_event)

func _physics_update(delta : float) -> void:
	# Se movendo
	PLAYER.player_movimentation(delta)
	
	if PLAYER.is_on_floor():
		if PLAYER.IS_TIRED == false:
			STATE_MACHINE.change_state("Free")
		else:
			STATE_MACHINE.change_state("Tired")
