extends CenterContainer


func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")
