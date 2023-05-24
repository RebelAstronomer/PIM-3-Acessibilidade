extends Position3D

onready var PLAYER = get_parent().get_parent()
onready var ANIMATION: AnimationPlayer = $AnimationPlayer
onready var INI_POS: Vector3 = translation

func _process(delta):
	if PLAYER.DIRECTION.x != 0:
		
		# Checando em qual estado o jogador está
		# e mudando a velocidade de movimento
		match PLAYER.ACT_STATE:
			"Free":
				if PLAYER.IS_RUNNING == true:
					ANIMATION.playback_speed = 1.7
				else:
					ANIMATION.playback_speed = 1
			"Tired":
				ANIMATION.playback_speed = 0.3
			"Dead":
				ANIMATION.stop()
		
		# Animação
		ANIMATION.play("walking_shake")
	else:
		ANIMATION.stop()
		# Resetando para a posição original
		translation.y = lerp(translation.y,INI_POS.y,0.03)

