extends Node2D

var openingMenu
var playSpace

func _ready():
	openingMenu = preload("res://Scenes/opening_menu.tscn").instantiate()
	playSpace = preload("res://Scenes/play_space.tscn").instantiate()
	add_child(openingMenu)

func _process(_delta):
	pass

func gameStart():
	remove_child(openingMenu)
	add_child(playSpace)
