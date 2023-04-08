extends Door

onready var ANIMATION: AnimationPlayer = $AnimationPlayer

func active():
	ANIMATION.play(ANIMATION_NAME)
