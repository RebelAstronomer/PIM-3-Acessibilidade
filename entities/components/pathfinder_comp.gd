extends Spatial

onready var TIMER: Timer = $Timer

var NAV_COMP: Navigation
var PATH := []
var curPathIndex := 0
var target = null
var threshold := .1

func _ready():
	target = Globals.PLAYER

func _physics_process(delta):
	if PATH.size() > 0:
		move_to_target(delta)

# Função para setar o valor de target
func set_target(newTarget: Player):
	target = newTarget

# Iniciando a perseguir
func active_timer():
	TIMER.start()

# Parando de perseguir
func stop_timer():
	TIMER.stop()

# Pegando a posição do alvo
func get_target_position():
	return target.global_transform.origin

func stop_moving():
	PATH = []

# Se movendo em direação do alvo
func move_to_target(delta):
	if global_transform.origin.distance_to(PATH[curPathIndex]) < threshold:
		PATH.remove(0)
	else:
		var direction = PATH[curPathIndex] - global_transform.origin
		owner.enemy_move_towards_direction(direction, delta)

# Pegando a posição do alvo dentro da Nav
func get_target_path(target_pos):
	PATH = NAV_COMP.get_simple_path(global_transform.origin, target_pos)
	curPathIndex = 0

# Se movendo após o timer acabar (a cada um segundo)
func _on_Timer_timeout():
	get_target_path(get_target_position())
