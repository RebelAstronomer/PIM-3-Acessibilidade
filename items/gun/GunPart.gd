extends Spatial

func picked_up():
	visible = false
	$interactive_body/CollisionShape.disabled = true
	Globals.add_gun_part()


func _on_interactive_body_interacted(body):
	picked_up()
