extends Spatial

onready var ANIMATION: AnimationPlayer = $AnimationPlayer

export var INTERATION_ON: PackedScene

var ANIMATION_ENDED: bool = false

func action(body):
	
	if Input.is_action_pressed("interact"):
		# Iniciando a animação
		ANIMATION.play("interact")



func _on_interactive_body_interacted(body):
	action(body)

func action_ended():
	ANIMATION_ENDED = true

func action_stated():
	ANIMATION_ENDED = false
