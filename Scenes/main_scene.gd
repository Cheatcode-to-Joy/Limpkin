extends Node2D

var openingMenu
var playSpace

var gameWidth
var gameHeight

func _ready():
	updateGameSize()
	openingMenu = preload("res://Scenes/opening_menu.tscn").instantiate()
	playSpace = preload("res://Scenes/play_space.tscn").instantiate()
	add_child(openingMenu)

func _process(_delta):
	pass

func gameStart():
	remove_child(openingMenu)
	add_child(playSpace)

func updateGameSize():
	gameWidth = ProjectSettings.get_setting("display/window/size/viewport_width")
	gameHeight = ProjectSettings.get_setting("display/window/size/viewport_height")
	get_tree().call_group("gameSizeDependent","updateGameSize",gameWidth,gameHeight)
