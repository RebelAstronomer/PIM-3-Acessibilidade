extends RayCast

#COMPONENTES#
onready var PROMPT: Label = get_parent().get_parent().get_node("HUD/Prompt")

func _ready():
	add_exception(owner)

func _physics_process(delta):
	PROMPT.text = ""
	if is_colliding():
		var detected = get_collider()
		
		# Checando se colidiu com algum item
		if detected is Interactable:
			
			if detected.IS_INTERACTABLE == true:
				PROMPT.text = detected.get_prompt()
				
				# Interagindo
				match detected.INTERACTION_TYPE:
					"Pickup":
						if Input.is_action_just_pressed(detected.PROMPT_ACTION):
							detected.interaction(owner)
					"Long":
						if Input.is_action_pressed(detected.PROMPT_ACTION):
							detected.interaction(owner)
		
