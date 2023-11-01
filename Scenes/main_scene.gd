extends Node2D

var playSpace

func _ready():
	playSpace = preload("res://Scenes/play_space.tscn")
	var thisPlaySpace = playSpace.instantiate()
	add_child(thisPlaySpace)

func _process(_delta):
	pass
