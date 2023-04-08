extends Node
class_name ActivatebleObject

export var ACTIVATED: bool = false
export var ANIMATION_NAME: String

func _ready():
	if ACTIVATED == true:
		active()

func active():
	pass
