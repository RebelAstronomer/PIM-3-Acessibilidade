extends Spatial


export(NodePath) onready var RAYCAST = get_node(RAYCAST)
onready var STREAM: AudioStreamPlayer3D = $AudioStreamPlayer3D
onready var ANIMATION: AnimationPlayer = $RootNode/AnimationPlayer

var canShoot: bool= true

func shoot():
	if canShoot == true:
		canShoot = false
		STREAM.play()
		ANIMATION.play("shoot")
		
		if RAYCAST.is_colliding():
			var detected = RAYCAST.get_collider()
			
			# Checando se colidiu com algum inimigo
			if detected.owner is Enemy:
				detected.owner.take_damage(2)



func _on_AnimationPlayer_animation_finished(anim_name):
	canShoot = true
