extends Control



func _on_StartBtn_pressed():
	get_tree().change_scene("res://Scene/worldTest.tscn")


func _on_ExitBtn_pressed():
	get_tree().quit()
