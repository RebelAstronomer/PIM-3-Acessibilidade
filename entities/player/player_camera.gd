extends Area

export var TRAUMA_REDUTION_RATE: float = 1.0
export var NOISE: OpenSimplexNoise
export var NOISE_SPEED: float = 50
export var MAX_X: float = 10.0
export var MAX_Y: float = 10.0
export var MAX_Z: float = 5.0

# COMPONENTES #
onready var CAMERA: Camera = $Camera
onready var INIT_ROT := CAMERA.rotation_degrees as Vector3

# VARIAVEIS #
var TRAUMA: float = 0.0
var TIME: float = 0.0

func _process(delta):
	TIME += delta
	# LIMITADORES #
	TRAUMA = max(TRAUMA - delta * TRAUMA_REDUTION_RATE, 0.0)
	
	# Tremendo a camera
	CAMERA.rotation_degrees.x = INIT_ROT.x + MAX_X * get_trauma_intensity() * get_noise_from_seed(0)
	CAMERA.rotation_degrees.y = INIT_ROT.y + MAX_Y * get_trauma_intensity() * get_noise_from_seed(1)
	CAMERA.rotation_degrees.z = INIT_ROT.z + MAX_Z * get_trauma_intensity() * get_noise_from_seed(2)

# Função para aplicar o trauma
func add_trauma(trauma_ammout: float):
	TRAUMA = clamp(TRAUMA + trauma_ammout, 0.0, 1.0)

func get_trauma_intensity() -> float:
	return TRAUMA * TRAUMA

func get_noise_from_seed(_seed: int) -> float:
	NOISE.seed = _seed
	return NOISE.get_noise_1d(TIME * NOISE_SPEED)
