extends Spatial
class_name Key

export var KEY_NAME: String = ""
export var KEY_SIGN: Texture

onready var highlighterMesh: MeshInstance = $highlighterMesh
onready var interactBody: StaticBody = $interactive_body
onready var sprite: Sprite3D = $MeshInstance/Sprite3D

# Variaveis para salvar a posição inicial na fase
var originPos: Vector3 = Vector3.ZERO
var originRot: Vector3 = Vector3.ZERO

func _ready():
	# Salvando a posição inicial na fase
	originPos = self.global_translation
	originRot = self.global_rotation
	
	# Definindo o nome da chave para o prompt
	var keyFinalName: String = "Pegar a chave " + KEY_NAME
	interactBody.PROMPT_MESSAGE = keyFinalName
	
	sprite.texture = KEY_SIGN

# Sendo pego
func _on_interactive_body_interacted(body):
	pick_uped()

# Função para ser pego
func pick_uped():
	if Globals.PLAYER.ITEM_IN_HAND == null:
		Globals.PLAYER.ITEM_IN_HAND = self
		highlighterMesh.visible = false

# Voltando a posição original
func reset_origin():
	highlighterMesh.visible = true
	self.global_translation = originPos
	self.global_rotation = originRot

func open_doors():
	pass
