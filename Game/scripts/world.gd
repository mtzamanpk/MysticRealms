extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()


func _on_desert_transition_point_body_entered(body):
	if body.has_method("player"):
		global.transitionScene = true


func _on_desert_transition_point_body_exited(body):
	if body.has_method("player"):
		global.transitionScene = false

func change_scene():
	if global.transitionScene == true:
		if global.currentScene == "world":
			get_tree().change_scene_to_file("res://scenes/desert.tscn")
			global.finishSceneTransition()
