extends EnemyState

export(NodePath) onready var PATH_FINDER = get_node(PATH_FINDER)
export(NodePath) onready var VISION_AREA = get_node(VISION_AREA)

func _ready():
	randomize()
	# Criando conecção com o cone de visão
	if !VISION_AREA.is_connected("see_the_target",self,"_on_VisionArea_see_the_target"):
		VISION_AREA.connect("see_the_target", self, "_on_VisionArea_see_the_target")

func _enter(_msg := {}) -> void:
	print(str(owner) + " has enter in " + self.name + " state")
	
	PATH_FINDER.start_random_moviment()

func _update(_delta: float) -> void:
	# Olhando para o alvo
	ENEMY.enemy_look_at(PATH_FINDER.get_target_position(), _delta)

func _on_VisionArea_see_the_target():
	if STATE_MACHINE.STATE == self:
		STATE_MACHINE.change_state("Chase")

func _exit() -> void:
	# Parando o pathfinder
	PATH_FINDER.stop_random_moviment()
