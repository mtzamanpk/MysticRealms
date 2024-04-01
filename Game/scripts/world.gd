extends Node2D

@onready var victory_screen = $VictoryScreen
@onready var coins_collected = $CanvasLayer/coinsCollected

func _ready():
	if global.gameFirstLoadIn == true:
		$player.position.x = global.playerStartPosX
		$player.position.y = global.playerStartPosY
	else:
		$player.position.x = global.playerExitDesertPosX
		$player.position.y = global.playerExitDesertPosY
	Events.coinsCollected.connect(showCoinsCollected)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()

func showCoinsCollected():
	coins_collected.show()

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
