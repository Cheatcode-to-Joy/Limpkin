extends Node2D

var gameWidth
var gameHeight

var buttonExit
var buttonMenu

func _ready():
	updateGameSize(get_tree().root.get_child(0).gameWidth,get_tree().root.get_child(0).gameHeight)
	
	buttonExit = preload("res://Scenes/HUD/button_exit.tscn").instantiate()
	add_child(buttonExit)
	buttonExit.scale = Vector2(0.2,0.2)
	buttonExit.position = Vector2(gameWidth-200,gameHeight-100)
	
	buttonMenu = preload("res://Scenes/HUD/button_menu.tscn").instantiate()
	add_child(buttonMenu)
	buttonMenu.scale = Vector2(0.2,0.2)
	buttonMenu.position = Vector2(gameWidth-200,gameHeight-200)

func _process(_delta):
	pass

func updateGameSize(width,height):
	gameWidth = width
	gameHeight = height
