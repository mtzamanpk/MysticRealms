extends Node

var playerCurrentAttack = false


var currentScene = "world"
var transitionScene = false

var playerExitDesertPosX = -205
var playerExitDesertPosY = -67

var playerStartPosX = -146
var playerStartPosY = 20

var gameFirstLoadIn = true


func finishSceneTransition():
	if transitionScene == true:
		transitionScene = false
		if currentScene == "world":
			currentScene = "desert"
		else:
			currentScene = "world"
