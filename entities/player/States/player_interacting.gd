extends PlayerState

func _enter(msg := {}) -> void:
	PLAYER.IS_INTERACTING = true

func _physics_update(delta: float):
	# Mover a camera
	PLAYER.player_look_throw_the_mouse()
