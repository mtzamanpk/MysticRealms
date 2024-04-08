extends CenterContainer

func _ready():
	RenderingServer.set_default_clear_color(Color.CORNFLOWER_BLUE)

func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://scenes/world.tscn")


func _on_quit_game_pressed():
	get_tree().quit() 


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/about.tscn")
