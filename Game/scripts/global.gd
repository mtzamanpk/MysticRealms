extends Node

var playerCurrentAttack = false


var currentScene = "world"
var transitionScene = false

var playerExitDesertPosX = 0
var playerExitNDesertPosY = 0

var playerStartPosX = 0
var playerStartPosY = 0

func finishSceneTransition():
	if transitionScene == true:
		transitionScene = false
		if currentScene == "world":
			currentScene = "desert"
		else:
			currentScene = "world"
