extends Node2D

var tile
var bee
var polyomino

var polyominos = {}

var heldPolyomino = null

var tileHeight = 100
var screenWidth
var screenHeight
var mousePosition = Vector2(0,0)
var grabPosition = Vector2(0,0)

var leftClickedOn = []
var rightClickedOn = []

func _ready():
	tile = preload("res://Scenes/tile_square.tscn")
	bee = preload("res://Scenes/bumblesheep.tscn")
	polyomino = preload("res://Scenes/polyomino.tscn")
	screenWidth = get_viewport().size.x
	screenHeight = get_viewport().size.y
	makeSideboard()

func _process(delta):
	# Regenerates all loose tiles and resets their position.
	if Input.is_action_just_pressed("Reset"):
		resetLoose()
	
	if Input.is_action_just_pressed("Grab or Let go"):
		if !heldPolyomino == null:
			heldPolyomino = null
		elif !leftClickedOn.size() == 0:
			heldPolyomino = leftClickedOn[0]
	
	if Input.is_action_just_pressed("Rotate"):
		if !rightClickedOn.size() == 0:
			rightClickedOn[0].rotatePolyomino()
	
	if !heldPolyomino == null:
		heldPolyomino.position = get_viewport().get_mouse_position() + grabPosition - mousePosition
	
	leftClickedOn = []
	rightClickedOn = []

func makeSideboard(tileNumber=3):
	var offsetX = tileHeight
	var offsetY = tileHeight
	for polyomino in range(tileNumber):
		var newPolyomino = makePolyomino()
		newPolyomino.position += Vector2(tileHeight*newPolyomino.widthTiles/2 + offsetX,
										 tileHeight*newPolyomino.heightTiles/2 + offsetY)
		offsetY += (newPolyomino.heightTiles+1)*tileHeight

func makePolyomino():
	var newPolyomino = polyomino.instantiate()
	add_child(newPolyomino)
	newPolyomino.init(tileHeight)
	polyominos[newPolyomino] = true
	return newPolyomino

func getActivePolyomino():
	# Finds the first polyomino whose rectangle is underneath the cursor.
	mousePosition = get_viewport().get_mouse_position()
	for polyomino in polyominos.keys():
		print(mousePosition)
		print(polyomino.position[0] + tileHeight*polyomino.widthTiles/2)
		print(polyomino.position[0] - tileHeight*polyomino.widthTiles/2)
		print(polyomino.position[1] + tileHeight*polyomino.heightTiles/2)
		print(polyomino.position[1] - tileHeight*polyomino.heightTiles/2)
		print("")
		if (mousePosition[0] < polyomino.position[0] + tileHeight*polyomino.widthTiles/2 and
			mousePosition[0] > polyomino.position[0] - tileHeight*polyomino.widthTiles/2 and 
			mousePosition[1] < polyomino.position[1] + tileHeight*polyomino.heightTiles/2 and
			mousePosition[1] > polyomino.position[1] - tileHeight*polyomino.heightTiles/2):
				return polyomino

func resetLoose():
	heldPolyomino = null
	for polyomino in polyominos.keys():
		polyominos.erase(polyomino)
		polyomino.queue_free()
	makeSideboard()

func onLeftClick(polyomino):
	leftClickedOn.append(polyomino)

func onRightClick(polyomino):
	rightClickedOn.append(polyomino)
