extends Node2D

var gameWidth
var gameHeight

var menuBox

var buttonExit
var buttonMenu
var buttonStart

func _ready():
	updateGameSize(get_tree().root.get_child(0).gameWidth,get_tree().root.get_child(0).gameHeight)
	
	menuBox = get_child(0)
	menuBox.scale = Vector2(0.4,0.4)
	menuBox.position = Vector2(gameWidth/2,3*gameHeight/4)
	
	buttonExit = preload("res://Scenes/HUD/button_exit.tscn").instantiate()
	menuBox.add_child(buttonExit)
	buttonExit.scale = Vector2(0.7,0.7)
	buttonExit.position = Vector2(0,350)
	
	buttonMenu = preload("res://Scenes/HUD/button_menu.tscn").instantiate()
	menuBox.add_child(buttonMenu)
	buttonMenu.scale = Vector2(0.7,0.7)
	buttonMenu.position = Vector2(0,0)
	
	buttonStart = preload("res://Scenes/HUD/button_start.tscn").instantiate()
	menuBox.add_child(buttonStart)
	buttonStart.scale = Vector2(0.7,0.7)
	buttonStart.position = Vector2(0,-350)

func _process(_delta):
	pass

func updateGameSize(width,height):
	gameWidth = width
	gameHeight = height
