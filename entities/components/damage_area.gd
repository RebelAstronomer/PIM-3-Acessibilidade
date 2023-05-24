extends Area
class_name DamageArea

export var DAMAGE: float
export(NodePath) onready var COLLISION_SHAPE = get_node(COLLISION_SHAPE)
export var COOLDOWN: float = 1

onready var COOLDOWN_TIMER: Timer = $cooldownAttack

func _ready():
	COOLDOWN_TIMER.wait_time = COOLDOWN

func _on_DamageArea_body_entered(body):
	COOLDOWN_TIMER.start()
	COLLISION_SHAPE.disabled = true


func _on_cooldownAttack_timeout():
	COLLISION_SHAPE.disabled = false
