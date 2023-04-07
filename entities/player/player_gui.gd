extends Control

# COMPONENTES #
onready var STAMINA_BAR: ProgressBar = $StaminaBar
onready var INTERACTION_BAR: ProgressBar = $ActionBar

# Variavel para salvar o node do jogador
var PLAYER: Player

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
