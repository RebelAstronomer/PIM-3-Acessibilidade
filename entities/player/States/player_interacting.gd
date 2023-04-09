extends PlayerState

func _enter(msg := {}) -> void:
	PLAYER.ACT_STATE = self.name
	PLAYER.IS_INTERACTING = true

func _handle_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		PLAYER.INTERACT_WITH.end_interaction()
		STATE_MACHINE.change_state("Free")

func _exit():
	PLAYER.IS_INTERACTING = false
