extends KinematicBody
class_name Enemy

# Velocidade de movimento
export var SPEED = 5
# Node para a navegação
export(NodePath) onready var NAV_COMP = get_node(NAV_COMP)

onready var PATH_FINDER := $PathFinderComp
onready var STREAM: AudioStreamPlayer3D = $AudioStreamPlayer3D

var velocity: Vector3 = Vector3.ZERO
var direction: Vector3 = Vector3.FORWARD

func _init():
	Globals.ENEMY = self

func _ready():
	PATH_FINDER.NAV_COMP = NAV_COMP

# Função para mover o inimigo
func enemy_move_towards_direction(dir: Vector3, delta):
	velocity = dir.normalized() * SPEED
	move_and_slide(velocity, delta * Vector3.UP)

func enemy_look_at(target: Vector3, delta: float):
	rotation.y = lerp_angle(rotation.y, atan2(-velocity.x, -velocity.z), delta * 4.0)
	$Body/Head.look_at(target,Vector3.UP)

func chage_player_now():
	PATH_FINDER.chasing_the_player()
	$StateMachine.change_state("Chase")

func play_sound(snd):
	STREAM.stream = snd
	STREAM.play()

func get_translation() -> Vector3:
	return global_translation

