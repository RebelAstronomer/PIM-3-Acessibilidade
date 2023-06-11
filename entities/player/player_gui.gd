extends Control

# COMPONENTES #
onready var STAMINA_BAR: ProgressBar = $StaminaBar
onready var INTERACTION_BAR: ProgressBar = $ActionBar
onready var VIGNETTE: ColorRect = $Vignette/ColorRect
onready var GUN_PARTS_COUNT: Label = $GunsParts

# Variavel para salvar o node do jogador
var PLAYER: Player
var isHurt: bool = false

func _init():
	Globals.HUD = self

func _ready():
	# Checando se o jogador já foi instanciado para carregar as informações
	yield(owner, "ready")
	
	# Checando se o node raiz é um node da classe Player
	PLAYER = owner as Player
	
	# Checando se foi encontrado um node com a classe Player
	# Caso não tenha sido encontrado, o nodo sera desligado
	# Evita bugs
	assert(PLAYER != null)
	
	# PASSANDO INFORMAÇÕES #
	STAMINA_BAR.max_value = PLAYER.MAX_STAMINA
	STAMINA_BAR.value = PLAYER.STAMINA

func _process(delta):
	
	# PASSANDO VALORES #
	STAMINA_BAR.value = PLAYER.STAMINA

func change_gun_parts_count(value):
	GUN_PARTS_COUNT.text = 'Partes: ' + str(value) + "/4"

func change_vignette_color(newColor: Color):
	VIGNETTE.material.set_shader_param("vignette_rgb", newColor)

func set_hurt(value: bool):
	isHurt = value

func vignette_hurt_effect():
	$Vignette/vignette_anim.play("blick_hurt")

func vignette_death_effect():
	$Vignette/vignette_anim.play("dead")

func resete_vignette():
	$Vignette/vignette_anim.play("RESET")
