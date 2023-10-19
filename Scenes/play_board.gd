extends Node2D

var tileHeight = 100
var tile = load("res://Scenes/tile_square.tscn")
var bbee = load("res://Scenes/bumblesheep.tscn")
var poly = load("res://Scenes/polyomino.tscn")
var screenWidth
var screenHeight
var looseTiles = {}
var grabbed = null
var mousePosition = Vector2(0,0)
var grabPosition = Vector2(0,0)

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
	if Input.is_action_just_pressed("Grab or Let go"):
		for polyomino in looseTiles:
			polyomino.changeProportions()
		if !grabbed == null:
			grabbed = null
		else:
			mousePosition = get_viewport().get_mouse_position()
			grabbed = getActivePolyomino()
			if grabbed:
				grabPosition = grabbed.position
	if Input.is_action_just_pressed("Rotate"):
		for polyomino in looseTiles:
			polyomino.changeProportions()
		if getActivePolyomino():
			getActivePolyomino().rotatePolyomino()
	if !grabbed == null:
		grabbed.position = get_viewport().get_mouse_position() + grabPosition - mousePosition

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
	var offsetX = tileHeight
	var offsetY = tileHeight
	for polyomino in range(3):
		var polyominoInstance = makePolyomino()
		looseTiles[polyominoInstance] = [polyominoInstance.topLeft,polyominoInstance.botRight]
		polyominoInstance.position += Vector2(tileHeight*polyominoInstance.centerX,
											  tileHeight*polyominoInstance.centerY)
		polyominoInstance.position += Vector2(offsetX, offsetY)
		offsetY += (polyominoInstance.actualHeight+1)*tileHeight
		polyominoInstance.grabPosition = polyominoInstance.position
		polyominoInstance.changeProportions()

func makePolyomino():
	var polyominoInstance = poly.instantiate()
	add_child(polyominoInstance)
	polyominoInstance.init()
	for space in polyominoInstance.tileDictionary.keys():
		if polyominoInstance.tileDictionary[space] == 1:
			var tileInstance = tile.instantiate()
			tileInstance.position = Vector2(tileHeight*(.5+space[0]-polyominoInstance.centerX),
											tileHeight*(.5+space[1]-polyominoInstance.centerY))
			polyominoInstance.add_child(tileInstance)
	return polyominoInstance

func getActivePolyomino():
	mousePosition = get_viewport().get_mouse_position()
	for polyomino in looseTiles.keys():
		if (mousePosition[0] < polyomino.botRight[0] and
			mousePosition[0] > polyomino.topLeft[0] and 
			mousePosition[1] < polyomino.botRight[1] and
			mousePosition[1] > polyomino.topLeft[1]):
				return polyomino

func resetLoose():
	for polyomino in looseTiles.keys():
		looseTiles.erase(polyomino)
		remove_child(polyomino)
	makeSideboard()
