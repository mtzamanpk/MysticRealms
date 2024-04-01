extends Node2D

@onready var victory_screen = $VictoryScreen

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.victoryScreen.connect(showVictoryScreen)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	changeScenes()


func showVictoryScreen():
	victory_screen.show()

func _on_desert_exit_body_entered(body):
	if body.has_method("player"):
		global.transitionScene = true


func _on_desert_exit_body_exited(body):
	if body.has_method("player"):
		global.transitionScene = false

func changeScenes():
	if global.transitionScene == true:
		if global.currentScene == "desert":
			get_tree().change_scene_to_file("res://scenes/world.tscn")
			global.finishSceneTransition()
