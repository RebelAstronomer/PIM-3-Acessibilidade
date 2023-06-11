extends Spatial
class_name Key

export var KEY_NAME: String = ""
export var KEY_SIGN: Texture
export var KEY_COLOR: Color = Color(1,1,1,1)

onready var highlighterMesh: MeshInstance = $highlighterMesh
onready var interactBody: StaticBody = $interactive_body
onready var sprite: Sprite3D = $KeyMesh/Sprite3D
onready var STREAM: AudioStreamPlayer3D = $AudioStreamPlayer3D
onready var SIGN_COLOR: MeshInstance = $KeyMesh/SignBackColor

# Variaveis para salvar a posição inicial na fase
var originPos: Vector3 = Vector3.ZERO
var originRot: Vector3 = Vector3.ZERO

# Sons
var pickupSound = preload("res://items/keys/key_pickup.wav")
var dropingSound = preload("res://items/keys/key_falling.wav")

func _ready():
	# Salvando a posição inicial na fase
	originPos = self.global_translation
	originRot = self.global_rotation
	
	# Definindo o nome da chave para o prompt
	var keyFinalName: String = "Pegar a chave " + KEY_NAME
	interactBody.PROMPT_MESSAGE = keyFinalName
	
	# Difinindo a cor e o simbolo da chave
	sprite.texture = KEY_SIGN
	SIGN_COLOR.get("material/0").set_shader_param("albedo",KEY_COLOR)

# Sendo pego
func _on_interactive_body_interacted(body):
	pick_uped()

func play_sound(snd):
	STREAM.stream = snd
	STREAM.play()

# Função para ser pego
func pick_uped():
	if Globals.PLAYER.ITEM_IN_HAND == null:
		play_sound(pickupSound)
		Globals.PLAYER.ITEM_IN_HAND = self
		highlighterMesh.visible = false

# Voltando a posição original
func reset_origin():
	play_sound(dropingSound)
	highlighterMesh.visible = true
	self.global_translation = originPos
	self.global_rotation = originRot

func drop_down():
	play_sound(dropingSound)
	highlighterMesh.visible = true
	self.global_transform = Globals.PLAYER.get_node("HurtBox").global_transform
	self.global_rotation = originRot
