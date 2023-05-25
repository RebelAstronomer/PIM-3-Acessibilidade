extends Area
class_name DamageArea

export var DAMAGE: float
export(NodePath) onready var COLLISION_SHAPE = get_node(COLLISION_SHAPE)
export var COOLDOWN: float = 1

onready var COOLDOWN_TIMER: Timer = $cooldownAttack
onready var STREAM: AudioStreamPlayer3D = $AudioStreamPlayer3D

var soundArray: Array = [
	preload("res://entities/enemy/sounds/enemy_attack_hit01.wav"),
	preload("res://entities/enemy/sounds/enemy_attack_hit02.wav"),
]

func _ready():
	randomize()
	COOLDOWN_TIMER.wait_time = COOLDOWN

func _on_DamageArea_body_entered(body):
	COOLDOWN_TIMER.start()
	play_random_sound()
	COLLISION_SHAPE.disabled = true


func _on_cooldownAttack_timeout():
	COLLISION_SHAPE.disabled = false

func play_random_sound():
	var index = rand_range(0, soundArray.size())
	play_sound(soundArray[index])

func play_sound(snd):
	STREAM.stream = snd
	STREAM.play()
