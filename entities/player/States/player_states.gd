extends State
class_name PlayerState

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
