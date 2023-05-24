extends Door

export(NodePath) onready var DOOR_KEY = get_node(DOOR_KEY)
export var DOOR_SIGN: Texture
export var SIGN_COLOR: Color

onready var ANIMATION: AnimationPlayer = $AnimationPlayer
onready var SIGN: Sprite3D = $right/Sprite3D
onready var STREAM: AudioStreamPlayer3D = $RandomAudioStreamPlayer3D

func _ready():
	randomize()
	SIGN.texture = DOOR_SIGN
	SIGN.modulate = SIGN_COLOR

func active():
	ANIMATION.play(ANIMATION_NAME)

func play_sound():
	STREAM.play()


func _on_interactive_body_interacted(body):
	if Globals.PLAYER.ITEM_IN_HAND == DOOR_KEY:
		active()
		Globals.PLAYER.remove_key_from_head(true)
