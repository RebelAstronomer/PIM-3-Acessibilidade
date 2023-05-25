extends Spatial
class_name LifeComp

# Sinal emitido após a vida zerar
signal is_dead
# Sinal de quando toma algum dano
signal is_hitted

onready var STREAM: AudioStreamPlayer3D = $RandomAudioStreamPlayer3D
onready var BLOOD_DROPS := preload("res://entities/components/blood_drops.tscn")

## Vida máxima/inicial
export var MAX_HP: float

## Vida atual, a qual sera alterada durante o game
var actHp: float
var printHp: bool = true

func _ready():
	# Definindo a vida atual ao ser criado
	actHp = MAX_HP

func _process(delta):
	# Limitando o HP para que não passe do máximo de HP predefinido
	limite_hp()

# Funçõa para receber e gerenciar o dano
func take_damage(value: float):
	
	# Checando se ainda tem vida pra ser removida
	if actHp > 0:
		actHp -= value
		STREAM.play()
		emit_signal("is_hitted")
	else:
		emit_signal("is_dead")
	
	if printHp == true:
		print_hp()

func print_hp():
	print(str(owner) + " has " + str(actHp))

func get_hp():
	return actHp

func set_hp(value: float):
	actHp = value

func limite_hp():
	actHp = clamp(actHp,0,MAX_HP)

func set_max_hp(value: float):
	MAX_HP = value

func get_max_hp():
	return MAX_HP

func create_blood_drops():
	var drops = BLOOD_DROPS.instance() as RigidBody
	self.add_child(drops)
