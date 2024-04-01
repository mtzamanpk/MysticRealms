extends Node2D

@onready var victory_screen = $VictoryScreen

func _ready():
	if global.gameFirstLoadIn == true:
		$player.position.x = global.playerStartPosX
		$player.position.y = global.playerStartPosY
	else:
		$player.position.x = global.playerExitDesertPosX
		$player.position.y = global.playerExitDesertPosY
	Events.victoryScreen.connect(showVictoryScreen)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()

func showVictoryScreen():
	victory_screen.show()

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
			global.gameFirstLoadIn = false
			global.finishSceneTransition()
