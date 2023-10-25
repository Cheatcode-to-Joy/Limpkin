extends Node2D

var tileScene
var tileHeight

var width = 8
var height = 8

var tiles = {}

func _ready():
	tileScene = preload("res://Scenes/Tiles/tile_square.tscn")
	tileHeight = get_parent().tileHeight
	position += Vector2(get_viewport().size.x-tileHeight*(1+width/2),tileHeight*(1+height/2))

func _process(_delta):
	pass

func makeBoard():
	tiles = {}
	for row in range(height):
		for column in range(width):
			var newTile = tileScene.instantiate()
			newTile.init("Basic",false,true)
			add_child(newTile)
			newTile.position = Vector2(tileHeight*(.5+column-width/2),
									   tileHeight*(.5+row-height/2))
			newTile.modulate.a = 0.5
			tiles[[row,column]] = newTile
