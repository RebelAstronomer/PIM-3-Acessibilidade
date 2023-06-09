extends EnemyState

export(NodePath) onready var PATH_FINDER = get_node(PATH_FINDER)
export(NodePath) onready var VISION_AREA = get_node(VISION_AREA)

var TARGET: Player = Globals.PLAYER
var targetInArea: bool = true

func _ready():
	randomize()
	# Criando conecção com o cone de visão
	if !VISION_AREA.is_connected("see_the_target",self,"_on_VisionArea_see_the_target"):
		VISION_AREA.connect("see_the_target", self, "_on_VisionArea_see_the_target")
	# Criando conecção com o cone de visão
	if !VISION_AREA.is_connected("lost_the_target",self,"_on_VisionArea_lost_the_target"):
		VISION_AREA.connect("lost_the_target",self,"_on_VisionArea_lost_the_target")

func _enter(_msg := {}) -> void:
	print(str(owner) + " has enter in " + self.name + " state")
	
	# Ativando o timer para que possa andar
	PATH_FINDER.start_chase_player()

func _update(_delta: float) -> void:
	# Olhando para o alvo
	ENEMY.enemy_look_at(TARGET.global_transform.origin, _delta)

func _on_VisionArea_see_the_target():
	print('to vendo')

func _on_VisionArea_lost_the_target():
	STATE_MACHINE.change_state("Alert")
	

func _exit() -> void:
	# Parando o pathfinder
	PATH_FINDER.stop_chase_player()
