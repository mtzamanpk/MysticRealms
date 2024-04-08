extends Node

var playerCurrentAttack = false


var currentScene = "world"
var transitionScene = false

var playerExitDesertPosX = -198
var playerExitDesertPosY = -74

var playerStartPosX = -135
var playerStartPosY = 23

var gameFirstLoadIn = true


func finishSceneTransition():
	if transitionScene == true:
		transitionScene = false
		if currentScene == "world":
			currentScene = "desert"
		else:
			currentScene = "world"


