extends EnemyState

export(NodePath) onready var PATH_FINDER = get_node(PATH_FINDER)
export(NodePath) onready var HEAD = get_node(HEAD)
export(NodePath) onready var VISION_AREA = get_node(VISION_AREA)
export(NodePath) onready var HEAD_ANIMATOR = get_node(HEAD_ANIMATOR)

func _enter(_msg := {}) -> void:
	print(str(owner) + " has enter in " + self.name + " state")
	
	PATH_FINDER.stop_moving()
	
	# Criando conecção com o cone de visão
	if !VISION_AREA.is_connected("see_the_target",self,"_on_VisionArea_see_the_target"):
		VISION_AREA.connect("see_the_target", self, "_on_VisionArea_see_the_target")
	
	# Animando
	HEAD_ANIMATOR.current_animation = "look_around"
	HEAD_ANIMATOR.play()

func _on_VisionArea_see_the_target():
	STATE_MACHINE.change_state("Chase")

func end_animation():
	VISION_AREA.disconnect("see_the_target",self,"_on_VisionArea_see_the_target")
	STATE_MACHINE.change_state("Idle")

