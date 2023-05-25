extends RigidBody

func _ready():
	randomize()
	var forceDir = Globals.PLAYER.translation.direction_to(translation)
	var randomVec = Vector3(rand_range(0,1),rand_range(0,1),rand_range(0,1)) * forceDir
	apply_impulse(randomVec,forceDir * 30)
