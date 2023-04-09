extends PlayerState

var CAN_REGEN: bool = false

func _enter(msg := {}) -> void:
	PLAYER.ACT_STATE = self.name
	# Definindo a velocidade inicial do jogador
	PLAYER.SPEED = PLAYER.SPEED_WALKING

func _physics_update(delta: float) -> void:
	# Checando se pode correr
	if Input.is_action_pressed("run") and PLAYER.IS_TIRED == false and PLAYER.CAN_RUN == true:
		start_running()
	# Parando de correr
	elif Input.is_action_just_released("run"):
		stop_running()
	
	# Correndo
	if PLAYER.IS_RUNNING == true:
		running()
	
	# Checando se pode regenerar stamina
	if CAN_REGEN == true and PLAYER.STAMINA < PLAYER.MAX_STAMINA:
		regen_stamina()
	
	# Se movendo
	PLAYER.player_movimentation(delta)

# Declarando que está correndo
func start_running():
	PLAYER.IS_RUNNING = true
	
	# Resetando o timer caso esteja ativado
	if PLAYER.STAMINA_TIMER.time_left > 0:
		reset_timer()

# Parando de correr, ativando o timer e resetando a velocidade normal
func stop_running():
	CAN_REGEN = false
	PLAYER.STAMINA_TIMER.start()
	PLAYER.SPEED = PLAYER.SPEED_WALKING
	PLAYER.IS_RUNNING = false

# Correndo, diminuindo a stamina e mudando a velocidade
func running():
	PLAYER.STAMINA -= 1
	PLAYER.SPEED = PLAYER.SPEED_RUN

# Regenerando a stamina
func regen_stamina():
	PLAYER.STAMINA += PLAYER.STAMINA_REGEN

# Resetando o timer
func reset_timer():
	PLAYER.STAMINA_TIMER.stop()
	PLAYER.STAMINA_TIMER.start()

# Recebendo o sinal após o termino do timer para poder regenerar
func _on_StaminaCountDown_timeout():
	CAN_REGEN = true
