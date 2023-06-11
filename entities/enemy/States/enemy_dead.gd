extends EnemyState

export(NodePath) onready var PATH_FINDER = get_node(PATH_FINDER)
export(NodePath) onready var DAMAGE_AREA = get_node(DAMAGE_AREA)
onready var ANIM: AnimationPlayer = $AnimationPlayer
var deadSnd = preload("res://entities/enemy/sounds/enemy_dead.wav")


func _enter(_msg := {}) -> void:
	print(str(owner) + " has enter in " + self.name + " state")
	
	# Som de morte
	ENEMY.play_sound(deadSnd)
	
	# Desativando a area de dano
	DAMAGE_AREA.queue_free()
	PATH_FINDER.stop_chase_player()
	ANIM.play("dying")
	
