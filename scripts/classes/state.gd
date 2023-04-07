extends Node
class_name State

var STATE_MACHINE = null


# ENTRAR NO ESTADO #
func _enter(_msg := {}) -> void:
	pass

# INPUTS DENTRO DO ESTADO #
func _handle_input(_event: InputEvent) -> void:
	pass

# PROCESS #
func _update(_delta: float) -> void:
	pass

# PROCESS FÍSICO #
func _physics_update(_delta: float) -> void:
	pass

# SAIR DO ESTADO # 
func _exit() -> void:
	pass
