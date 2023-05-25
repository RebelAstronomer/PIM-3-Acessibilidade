extends Node

# Script para variaveis globais #
var PLAYER: Player
var ENEMY: Enemy

func get_player_position() -> Vector3:
	return PLAYER.global_translation
