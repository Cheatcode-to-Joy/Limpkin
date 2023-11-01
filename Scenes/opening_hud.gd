extends Node2D

var buttonExit
var buttonMenu
var buttonStart

func _ready():
	buttonExit = preload("res://Scenes/HUD/button_exit.tscn").instantiate()
	add_child(buttonExit)
	buttonExit.scale = Vector2(0.2,0.2)
	buttonExit.position = Vector2(get_viewport().size.x-500,get_viewport().size.y-300)
	
	buttonMenu = preload("res://Scenes/HUD/button_menu.tscn").instantiate()
	add_child(buttonMenu)
	buttonMenu.scale = Vector2(0.2,0.2)
	buttonMenu.position = Vector2(get_viewport().size.x-500,get_viewport().size.y-400)
	
	buttonStart = preload("res://Scenes/HUD/button_start.tscn").instantiate()
	add_child(buttonStart)
	buttonStart.scale = Vector2(0.2,0.2)
	buttonStart.position = Vector2(get_viewport().size.x-500,get_viewport().size.y-500)

func _process(_delta):
	pass
