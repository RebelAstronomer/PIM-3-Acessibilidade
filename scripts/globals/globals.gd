extends Node

const GUN_MAX_PARTS: int = 4

# Script para variaveis globais #
var PLAYER: Player
var ENEMY: Enemy
var GUN_PARTS: int = 0
var HUD: Control

func get_player_position() -> Vector3:
	return PLAYER.global_translation

func add_gun_part():
	# Adicionando a parte da arma
	GUN_PARTS += 1
	
	# Alternado a hud
	HUD.change_gun_parts_count(GUN_PARTS)
	
	# Checando se a arma está completa
	if check_gun_number() == true:
		PLAYER.HAS_A_GUN = true
		PLAYER.GUN.visible = true

func check_gun_number():
	if GUN_PARTS == 4:
		return true
	else:
		return false
