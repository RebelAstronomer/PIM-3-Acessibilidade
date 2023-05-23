extends Node

# Script para variaveis globais #
var PLAYER: Player

func get_player_position() -> Vector3:
	return PLAYER.global_translation
