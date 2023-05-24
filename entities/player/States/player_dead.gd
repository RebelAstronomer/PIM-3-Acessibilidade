extends PlayerState


var DEATH_SND = preload("res://entities/player/sounds/SCREAM.wav")

func _enter(msg := {}) -> void:
	PLAYER.ACT_STATE = self.name
	
	PLAYER.ANIMATION.play("death")
	PLAYER.set_audio_to_play(DEATH_SND,true)
