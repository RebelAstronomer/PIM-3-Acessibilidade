extends EnemyState

export(NodePath) onready var PATH_FINDER = get_node(PATH_FINDER)
export(NodePath) onready var VISION_AREA = get_node(VISION_AREA)

func _enter(_msg := {}) -> void:
	# Criando conecção com o cone de visão
	if !VISION_AREA.is_connected("see_the_target",self,"_on_VisionArea_see_the_target"):
		VISION_AREA.connect("see_the_target", self, "_on_VisionArea_see_the_target")
	
	print(str(owner) + " has enter in " + self.name + " state")

func _on_VisionArea_see_the_target():
	VISION_AREA.disconnect("see_the_target",self,"_on_VisionArea_see_the_target")
	STATE_MACHINE.change_state("Chase")
