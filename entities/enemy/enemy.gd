extends KinematicBody

export var SPEED = 5

var PATH := []
var curPathIndex := 0
var target = null
var velocity := Vector3.ZERO
var threshold := .1

onready var nav = get_parent()

func _ready():
	target = Globals.PLAYER

func _physics_process(delta):
	if PATH.size() > 0:
		move_to_target()
	

func move_to_target():
	if global_transform.origin.distance_to(PATH[curPathIndex]) < threshold:
		PATH.remove(0)
	else:
		var direction = PATH[curPathIndex] - global_transform.origin
		velocity = direction.normalized() * SPEED
		move_and_slide(velocity, Vector3.UP)

func get_target_path(target_pos):
	PATH = nav.get_simple_path(global_transform.origin, target_pos)
	curPathIndex = 0

func _on_PathfinderTimer_timeout():
	get_target_path(target.global_transform.origin)
