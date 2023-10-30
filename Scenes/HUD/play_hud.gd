extends Node2D

var buttonExit

func _ready():
	buttonExit = preload("res://Scenes/HUD/button_exit.tscn")
	var thisButtonExit = buttonExit.instantiate()
	add_child(thisButtonExit)
	thisButtonExit.scale = Vector2(0.2,0.2)
	thisButtonExit.position = Vector2(get_viewport().size.x-500,get_viewport().size.y-300)

func _process(_delta):
	pass
