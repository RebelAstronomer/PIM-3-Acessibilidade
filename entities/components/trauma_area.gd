extends Area
class_name TraumaArea

export var TRAUMA_AMMOUNT: float = 0.1

func cause_trauma():
	# Detectando colisões com as areas
	var traumaAreas = get_overlapping_areas()
	for area in traumaAreas:
		# Se uma das areas tiver a função add_trauma, passe os valores para ela 
		if area.has_method("add_trauma"):
			area.add_trauma(TRAUMA_AMMOUNT)

# Checando se o jogador foi acertado e tremendo a camera
func _on_LifeComp_is_hitted():
	cause_trauma()
