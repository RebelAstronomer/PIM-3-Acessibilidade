extends EnemyState

export(NodePath) onready var PATH_FINDER = get_node(PATH_FINDER)
export(NodePath) onready var VISION_AREA = get_node(VISION_AREA)
export(NodePath) onready var DAMAGE_AREA = get_node(DAMAGE_AREA)

var TARGET: Player = Globals.PLAYER
var targetInArea: bool = true
var chaseSounds: Array = [
	preload("res://entities/enemy/sounds/enemy_chase_giveUp.wav"),
	preload("res://entities/enemy/sounds/enemy_chase_hello.wav"),
	preload("res://entities/enemy/sounds/enemy_chase_laugh01.wav"),
	preload("res://entities/enemy/sounds/enemy_chase_laugh02.wav"),
	preload("res://entities/enemy/sounds/enemy_chase_laugh03.wav"),
	preload("res://entities/enemy/sounds/enemy_chase_tonighYouDie.wav"),
	preload("res://entities/enemy/sounds/enemy_chase_youAreDead.wav")
]

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
	
	# Som
	play_random_chase_sound()
	
	# Ativando o timer para que possa andar
	PATH_FINDER.start_chase_player()
	
	# Ativando a area de dano
	DAMAGE_AREA.monitoring = true

func _update(_delta: float) -> void:
	# Olhando para o alvo
	ENEMY.enemy_look_at(TARGET.global_transform.origin, _delta)

func _on_VisionArea_see_the_target():
	pass

func _on_VisionArea_lost_the_target():
	if STATE_MACHINE.STATE == self:
		STATE_MACHINE.change_state("Alert")
	

func _exit() -> void:
	# Parando o pathfinder
	PATH_FINDER.stop_chase_player()
	# Desativando a area de dano
	DAMAGE_AREA.monitoring = false

func play_random_chase_sound():
	var index = rand_range(0,chaseSounds.size())
	ENEMY.play_sound(chaseSounds[index])
