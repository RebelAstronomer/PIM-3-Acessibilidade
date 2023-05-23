extends Spatial

onready var TIMER_RAND: Timer = $MoveRandomTimer
onready var TIMER_CHASE: Timer = $ChaseTimer
export(float, 1, 5) var TIMER_TO_WAIT: float = 1

# Node para a navegação
var NAV_COMP: Navigation
var path: Array = []
var pathNode: int = 0
var speed: int = 7
const GRAVITY: int = 10
var verticalVel: Vector3 = Vector3()
var targetToFollow: Vector3 = Vector3()
var threshold: float = 0.1

func _ready():
	randomize()
	
	# Pegando um timer aleatório para se mover
	TIMER_RAND.wait_time = rand_range(TIMER_TO_WAIT, 5)

func start_chase_player():
	TIMER_CHASE.start()

func stop_chase_player():
	TIMER_CHASE.stop()

func start_random_moviment():
	TIMER_RAND.start()

func stop_random_moviment():
	TIMER_RAND.stop()

func get_target_position() -> Vector3:
	return targetToFollow

func move_down(delta):
	if not owner.is_on_floor():
		verticalVel.y -= GRAVITY * delta

func move_to(targetPos):
	path =  NAV_COMP.get_simple_path(global_transform.origin, NAV_COMP.get_closest_point(targetPos))
	pathNode = 0

func _physics_process(delta):
	if pathNode < path.size():
		
		var direction = (path[pathNode] - global_transform.origin)
		if direction.length() < 1:
			pathNode += 1
		else:
			owner.enemy_move_towards_direction(direction, delta)

func get_random_point(radius: float) -> Vector3:
	var x1 = rand_range(-1, 1)
	var x2 = rand_range(-1, 1)
	
	while x1*x1 + x2*x2 >= 1:
		x1 = rand_range(-1, 1)
		x2 = rand_range(-1, 1)
	
	var randomPos = Vector3(
		2 * x1 * sqrt(1 - x1*x1 - x2*x2),
		2 * x2 * sqrt(1 - x1*x1 - x2*x2),
		1 - 2 * (x1*x1 + x2*x2)
	)
	
	return randomPos * rand_range(0, radius)
 

func _on_ChaseTimer_timeout():
	targetToFollow = Vector3(Globals.get_player_position().x,Globals.get_player_position().y,Globals.get_player_position().z)
	move_to(targetToFollow)

func _on_MoveRandomTimer_timeout():
	TIMER_RAND.wait_time = rand_range(TIMER_TO_WAIT, 5)
	TIMER_RAND.stop()
	targetToFollow = Vector3(get_random_point(20).x,0,get_random_point(20).z) + owner.global_transform.origin
	move_to(targetToFollow)
