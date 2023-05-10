extends State
class_name EnemyState

# Variavel para salvar o node do jogador
var ENEMY: Enemy

func _ready():
	# Checando se o jogador já foi instanciado para carregar as informações
	yield(owner, "ready")
	
	# Checando se o node raiz é um node da classe Player
	ENEMY = owner as Enemy
	
	# Checando se foi encontrado um node com a classe Player
	# Caso não tenha sido encontrado, o nodo sera desligado
	# Evita bugs
	assert(ENEMY != null)

