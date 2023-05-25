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
	
	# Esparando o Timer acabar para escolher o que fazer
	$AlertCooldown.wait_time = rand_range(1,5)
	$AlertCooldown.start()


func _on_VisionArea_see_the_target():
	if STATE_MACHINE.STATE == self:
		STATE_MACHINE.change_state("Chase")

func _on_AlertCooldown_timeout():
	$AlertCooldown.stop()
	
	var percent = rand_range(0,100)
	if percent > 50:
		STATE_MACHINE.change_state("Idle")
	else:
		STATE_MACHINE.change_state("MoveRandom")

