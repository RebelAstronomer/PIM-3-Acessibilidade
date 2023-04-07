extends Node
class_name StateMachine

# Emitindo sinal ao mudar de estado
signal transitioned(state_name, old_state)

# Pegando o estado inicial
export var INIT_STATE := NodePath()
onready var STATE: State = get_node(INIT_STATE)

var OLD_STATE: State

func _ready():
	# Esperando para que o dono esteja pronto
	yield(owner, "ready")
	
	# Pegando todos os estados se definie como State Machine para eles
	for child in get_children():
		child.STATE_MACHINE = self
	
	# Inicializando o estado
	STATE._enter()

# Passando as informações dos inputs para o estado
func _unhandled_input(event):
	STATE._handle_input(event)

# Passando as informações do process para o estado
func _process(delta):
	STATE._update(delta)

# Passando as informações de física para o estado
func _physics_process(delta):
	STATE._physics_update(delta)

# Função para mudar de estado
func change_state(new_state: String, msg: Dictionary = {}) -> void:
	
	# Checando se não foi passado nem um estado como definição
	# Caso não tenha sido passado, a função sera passada
	if not has_node(new_state):
		return
	
	# Salvando o ultimo estado
	OLD_STATE = STATE
	
	STATE._exit()
	STATE = get_node(new_state)
	STATE._enter(msg)
	emit_signal("transitioned", STATE.name , OLD_STATE.name)
