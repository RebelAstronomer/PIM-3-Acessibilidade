extends Spatial
class_name InteractableItem

export(AudioStream) var INIT_INTERACT_SOUND
export(AudioStream) var END_INTERACT_SOUND
onready var AUDIO_STREAM: AudioStreamPlayer3D

func end_interaction():
	pass

func action(body):
	pass

func play_audio(audio):
	AUDIO_STREAM.stream = INIT_INTERACT_SOUND
	AUDIO_STREAM.play()
