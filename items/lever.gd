extends InteractableItem

onready var ANIMATION: AnimationPlayer = $AnimationPlayer
onready var INTERACT_AREA: StaticBody = $interactive_body

export(NodePath) var NODE_PATH
export var ANIMATION_SPEED: float = 1

var IS_ACTIVATED: bool = false
var ANIMATION_END: bool = false
var INTERATION_ON

func _ready():
	# Setando a velocidade da animação
	ANIMATION.playback_speed = ANIMATION_SPEED
	if NODE_PATH != "":
		INTERATION_ON = get_node(NODE_PATH)
	else: 
		pass

func action(body):
	
	# Desativando a interação
	INTERACT_AREA.IS_INTERACTABLE = false
	
	ANIMATION.play("interact")

func _on_interactive_body_interacted(body):
	action(body)


func _on_AnimationPlayer_animation_finished(anim_name):
	INTERATION_ON.active()
