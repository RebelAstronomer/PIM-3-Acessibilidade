extends Area
class_name HurtBox

## Componente de vida
export(NodePath) onready var LIFE_COMP = get_node(LIFE_COMP)


func apply_damage(value: float):
	# Checando se foi definido algum componente de vida
	# Caso não tenha sido definindo, mostre uma mensagem de erro
	# Caso tenha sido definido, aplique dano ao componente
	if LIFE_COMP != null: 
		LIFE_COMP.take_damage(value)
	else:
		print(str(owner) + " dont have a Life Compente to resive damage")

func _on_HurtBox_body_entered(body):
	if body.get("DAMAGE") != null:
		apply_damage(body.DAMAGE)


func _on_HurtBox_area_entered(area):
	if area.get("DAMAGE") != null:
		apply_damage(area.DAMAGE)
