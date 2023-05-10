extends Area
class_name VisionArea

signal see_the_target
signal lost_the_target
signal target_is_in_area
signal target_is_not_in_area

export(NodePath) onready var RAY_CAST = get_node(RAY_CAST)

func _on_VisionTimer_timeout():
	check_visual_contact()

func check_visual_contact():
	# Checando se colidiu com algo
	var overlaps = self.get_overlapping_bodies()
	if overlaps.size() > 0:
		# Procurando pelo o jogador entre os objetos colididos
		for overlap in overlaps:
			if overlap.name == "Player":
				# Salvando a posição do jogador
				var playerPos = overlap.global_transform.origin
				RAY_CAST.look_at(playerPos, Vector3.UP)
				RAY_CAST.force_raycast_update()
				# Emitindo sinal de que o jogador está na área
				emit_signal("target_is_in_area")
				# Checando se o Raycast colidiu com algo
				if RAY_CAST.is_colliding():
					var collider = RAY_CAST.get_collider()
					
					# Checando se o Raycast consegue ver o jogador
					if collider.name == "Player":
						emit_signal("see_the_target")
					else:
						emit_signal("lost_the_target")
			else:
				emit_signal("target_is_not_in_area")
