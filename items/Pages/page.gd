extends InteractableItem

export(String, MULTILINE) var TEXT: String
export(Texture) var PAGE_TEXT

onready var AUDIO_STREAM: AudioStreamPlayer = $AudioStreamPlayer

var PAGE_CTRL: Control = null

func action(body):
	# Audio
#	AUDIO_STREAM.stream = INIT_INTERACT_SOUND
	AUDIO_STREAM.play()
	# Pegando o controlador
	PAGE_CTRL = body.HUD.get_node("Page")
	# Definindo a textura da página
	PAGE_CTRL.get_node("PageTexture").texture = PAGE_TEXT
	# Aplicando o texto da página
	PAGE_CTRL.get_node("PageText").text = TEXT
	# Deixando visivel a página
	PAGE_CTRL.visible = true
	# Mudando o estado do jogador
	body.STATE_MACHINE.change_state("Interacting")
	# Declarando ao jogador seu ID
	body.INTERACT_WITH = self
	pass

# Função para o fim da interação
func end_interaction():
	if PAGE_CTRL != null:
		# Audio
#		AUDIO_STREAM.stream = END_INTERACT_SOUND
		AUDIO_STREAM.play()
		# Desabilitando a colisão do interactive_body
		get_node("interactive_body/CollisionShape").disabled = true
		# Iniciando contador
		get_node("interactCooldown").start()
		# Desativando a página
		PAGE_CTRL.visible = false
	
	pass

func _on_interactive_body_interacted(body):
	# Iniciando ação
	action(body)
	

# Resetando a colisão do interactive_body
func _on_interactCooldown_timeout():
	get_node("interactive_body/CollisionShape").disabled = false



func _on_AudioStreamPlayer_finished():
	AUDIO_STREAM.stop()
	print('parei')
