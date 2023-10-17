extends Node2D

var tileHeight = 100
var tile = load("res://Scenes/tile_square.tscn")
var bbee = load("res://Scenes/bumblesheep.tscn")
var poly = load("res://Scenes/polyomino.tscn")
var movable = load("res://Scenes/movable.tscn")
var screenWidth
var screenHeight
var looseTiles = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	screenWidth = get_viewport().size.x
	screenHeight = get_viewport().size.y
	makeBoard()
	makeSideboard()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Reset"):
		resetLoose()

func makeBoard():
	var tiles = 8
	for row in range(tiles):
		for column in range(tiles):
			var tileInstance = tile.instantiate()
			var bbeeInstance = bbee.instantiate()
			tileInstance.position = Vector2((screenWidth-tileHeight)-tileHeight*row,
											(screenHeight-(tiles*tileHeight)/2)+tileHeight*column)
			add_child(tileInstance)
			tileInstance.add_child(bbeeInstance)

func makeSideboard():
	var looseTileX = tileHeight
	var looseTileY = tileHeight
	for polyomino in range(3):
		var polyominoInstance = makePolyomino(looseTileX, looseTileY)
		looseTiles[polyominoInstance] = true
		looseTileY += (polyominoInstance.actualHeight+2)*tileHeight

func makePolyomino(looseTileX, looseTileY):
	var polyominoInstance = poly.instantiate()
	var polyomino = polyominoInstance.init()
	for space in polyomino.keys():
		if polyomino[space] == 1:
			var tileInstance = tile.instantiate()
			var isMovable = movable.instantiate()
			tileInstance.position = Vector2(looseTileX + tileHeight*space[0],
											looseTileY + tileHeight*space[1])
			tileInstance.add_child(isMovable)
			polyominoInstance.add_child(tileInstance)
	add_child(polyominoInstance)
	return polyominoInstance

func resetLoose():
	for polyomino in looseTiles.keys():
		looseTiles.erase(polyomino)
		remove_child(polyomino)
	makeSideboard()
