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
	
	# Iniciando o timer para mudar de estado
	$ChooseActionTimer.wait_time = rand_range(1,5)
	$ChooseActionTimer.start()

func _on_VisionArea_see_the_target():
	STATE_MACHINE.change_state("Chase")

func _exit() -> void:
	$ChooseActionTimer.stop()


func _on_ChooseActionTimer_timeout():
	var percent = rand_range(0,100)
	if percent > 50:
		STATE_MACHINE.change_state("MoveRandom")
	else:
		STATE_MACHINE.change_state("Idle")
