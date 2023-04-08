extends StaticBody
class_name Interactable

signal interacted(body)

export var INTERACTION_TYPE: String = "Pickup"

# STATUS #
export var PROMPT_MESSAGE: String = "Interact"
export var PROMPT_ACTION  = "interact"

var IS_INTERACTABLE: bool = true

# Mostrando ação do item
func get_prompt():
	var keyName = ""
	for action in InputMap.get_action_list(PROMPT_ACTION):
		if action is InputEventKey:
			keyName = OS.get_scancode_string(action.scancode)
	return PROMPT_MESSAGE + "\n" + keyName

# Interagindo
func interaction(body):
	emit_signal("interacted", body)
