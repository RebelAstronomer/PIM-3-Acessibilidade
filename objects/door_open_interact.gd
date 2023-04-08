extends Door

onready var ANIMATION: AnimationPlayer = $AnimationPlayer

func active():
	# Abrindo ou fechando a porta
	OPEN = !OPEN
	
	# Checando se pode abrir ou fechar a porta
	if OPEN == true and FULL_OPEN == true:
		ANIMATION.play(ANIMATION_NAME)
		FULL_OPEN = false
	elif OPEN == true and FULL_OPEN == true:
		ANIMATION.play(ANIMATION_NAME)
		FULL_OPEN = false

func _on_interactive_body_interacted(body):
	active()

func _on_AnimationPlayer_animation_finished(anim_name):
	FULL_OPEN = true

# Definindo a animação de abrir
func change_anim_name_open():
	ANIMATION_NAME = "open"
	FULL_OPEN = true

# Definindo a animação de fechar
func change_anim_name_closed():
	ANIMATION_NAME = "close"
	FULL_OPEN = true
