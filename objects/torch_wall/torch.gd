extends Spatial

export(float, 0.1, 2) var ANIMATION_SPEED: float = 1

onready var ANIMATION: AnimationPlayer = $AnimationPlayer

func _ready():
	ANIMATION.playback_speed = ANIMATION_SPEED
