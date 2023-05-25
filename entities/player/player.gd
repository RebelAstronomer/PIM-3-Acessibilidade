extends KinematicBody
class_name Player

# STATUS #
export var SPEED_WALKING: float = 7
export var SPEED_RUN: float = 15
export var SPEED_TIRED: float = 3
export var STAMINA_REGEN: float = 0.6
export var MAX_STAMINA: float = 200
export var ACCEL: float = 10
export var JUMP_FORCE: float = 15
export var GRAVITY: float = 50
export var MOUSE_SENSI: float = 0.2

# COMPONENTES # 
onready var HEAD: Spatial = $Head
onready var CAMERA: Camera = $Head/PlayerCamera/Camera
onready var RAYCAST: RayCast = $Head/interactCast
onready var STATE_MACHINE: StateMachine = $StateMachine
onready var STAMINA_TIMER: Timer = $StaminaCountDown
onready var HUD: Control = $HUD
onready var STREAM: AudioStreamPlayer3D = $Head/AudioStreamPlayer3D
onready var ITEMS_HAND: Position3D = $Head/itemPos
onready var ANIMATION: AnimationPlayer = $AnimationPlayer

# VARIAVEIS #
var LOOK_ROT: Vector3 = Vector3.ZERO
var DIRECTION: Vector3 = Vector3.ZERO
var VELOCITY: Vector3 = Vector3.ZERO
var STAMINA: float = MAX_STAMINA
var MAX_ANGLE: float = 90
var MIN_ANGLE: float = -80
var IS_RUNNING: bool = false
var IS_TIRED: bool = false
var IS_INTERACTING: bool = false
var CAN_RUN: bool = true
var SPEED: float
var ACT_STATE: String
var INTERACT_WITH
var ITEM_IN_HAND: Object = null

var SHOW_MOUSE: bool = false

func _init():
	Globals.PLAYER = self

func _ready():
	# Desabilitando o mouse na tela
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	# Resetando a vinheta após a morte
	HUD.resete_vignette()

func _process(delta):
	# Limitadores #
	STAMINA = clamp(STAMINA, 0, MAX_STAMINA)
	
	# Pegando a chave
	if ITEM_IN_HAND != null:
		ITEM_IN_HAND.global_transform = ITEMS_HAND.global_transform
	

func _input(event):
	# Fechando o game
	if Input.is_action_just_pressed("quit_game"):
		get_tree().quit()
	
	# Resetando a cena
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	
	if Input.is_action_just_pressed("drop") and ITEM_IN_HAND != null:
		remove_key_from_head(false)
	
	# Mostrando o mouse
	if Input.is_action_just_pressed("show_mouse"):
		SHOW_MOUSE = !SHOW_MOUSE
	
	if SHOW_MOUSE == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Removendo a chave da mão
func remove_key_from_head(destroy: bool):
	if ITEM_IN_HAND != null:
		if destroy == false:
			ITEM_IN_HAND.drop_down()
			ITEM_IN_HAND = null
		else:
			ITEM_IN_HAND.queue_free()
			ITEM_IN_HAND = null

# Movimentação do jogador
func player_movimentation(_delta: float):
	# Rotacionando a camera
	player_look_throw_the_mouse()
	
	# Ficando cansado
	if STAMINA <= 0:
		STATE_MACHINE.change_state("Tired")
	
	# Grvidade
	if not is_on_floor():
		VELOCITY.y -= GRAVITY * _delta
	
	# Pular
	if Input.is_action_just_pressed("jumping") and not IS_RUNNING and is_on_floor():
		STATE_MACHINE.change_state("OnAir")
	
	# Direção da movimentação
	DIRECTION = Vector3(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		0,
		Input.get_action_strength("move_back") - Input.get_action_strength("move_foward")
	).normalized().rotated(Vector3.UP, rotation.y)
	
	# Força de movimentação
	VELOCITY.x = lerp(VELOCITY.x, DIRECTION.x * SPEED, ACCEL * _delta)
	VELOCITY.z = lerp(VELOCITY.z, DIRECTION.z * SPEED, ACCEL * _delta)
	
	# Se movendo
	VELOCITY = move_and_slide(VELOCITY, Vector3.UP)

# Rotacionando a camera
func player_look_throw_the_mouse():
	 # Girando a cabeça de acordo com a direção do mouse
	HEAD.rotation_degrees.x = LOOK_ROT.x
	rotation_degrees.y = LOOK_ROT.y

func player_mouse_input(event):
	# Pegando a direção do mouse
	if event is InputEventMouseMotion:
		LOOK_ROT.x -= (event.relative.y * MOUSE_SENSI)
		LOOK_ROT.y -= (event.relative.x * MOUSE_SENSI)
		LOOK_ROT.x = clamp(LOOK_ROT.x, MIN_ANGLE, MAX_ANGLE)

func set_audio_to_play(value,play: bool):
	STREAM.stream = value
	print(STREAM.stream)
	if play == true:
		STREAM.play()

func play_audio():
	STREAM.play()

func reset_audio():
	STREAM.stop()
	STREAM.stream = null

func _on_StateMachine_transitioned(state_name, old_state):
	print("Player is on " + state_name + " Player old state is " + old_state)

# Tela de morte
func _on_LifeComp_is_dead():
	STATE_MACHINE.change_state("Dead")
	HUD.vignette_death_effect()

# Recebendo dano
func _on_LifeComp_is_hitted():
	HUD.vignette_hurt_effect()
