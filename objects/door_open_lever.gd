extends Door

export(NodePath) onready var DOOR_KEY = get_node(DOOR_KEY)
export var DOOR_SIGN: Texture
export var SIGN_COLOR: Color = Color(1,1,1,1)

onready var ANIMATION: AnimationPlayer = $AnimationPlayer
onready var SIGN: Sprite3D = $right/Sprite3D
onready var STREAM: AudioStreamPlayer3D = $RandomAudioStreamPlayer3D
onready var UNLOCK_STREAM: AudioStreamPlayer3D = $AudioStreamPlayer3D
onready var SIGN_MESH: MeshInstance = $right/SignColor

func _ready():
	randomize()
	SIGN.texture = DOOR_SIGN
	SIGN_MESH.get("material/0").albedo_color = SIGN_COLOR

func active():
	alarm_the_enemy()
	
	UNLOCK_STREAM.play()
	play_sound()
	ANIMATION.play(ANIMATION_NAME)

func play_sound():
	STREAM.play()

# Chase de alarmar o inimigo
func alarm_the_enemy():
	var percent = randf()
	print(percent)
	if percent > 0.8:
		Globals.ENEMY.chage_player_now()

func _on_interactive_body_interacted(body):
	if Globals.PLAYER.ITEM_IN_HAND == DOOR_KEY:
		active()
		Globals.PLAYER.remove_key_from_head(true)
