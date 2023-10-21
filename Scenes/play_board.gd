extends Node2D

var tile
var bee
var polyomino

var polyominos = {}

var heldPolyomino = null

var tileHeight = 100
var screenWidth
var screenHeight
var grabOffset = Vector2(0,0)

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
			grabOffset = heldPolyomino.position - get_viewport().get_mouse_position()
	
	if Input.is_action_just_pressed("Rotate"):
		if !heldPolyomino == null:
			heldPolyomino.rotatePolyomino()
		elif !rightClickedOn.size() == 0:
			rightClickedOn[0].rotatePolyomino()
	
	if !heldPolyomino == null:
		heldPolyomino.position = get_viewport().get_mouse_position() + grabOffset
	
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
