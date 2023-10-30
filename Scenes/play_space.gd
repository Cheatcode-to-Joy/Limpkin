extends Node2D

var polyomino
var polyominos = {}

var heldPolyomino = null

var tileHeight = 100
var grabOffset = Vector2(0,0)

var leftClickedOn = []
var rightClickedOn = []

signal letGo(activePolyomino)

func _ready():
	polyomino = preload("res://Scenes/Tiles/polyomino.tscn")
	var board = get_child(0)
	board.makeBoard()
	letGo.connect(board.slotPolyomino)
	makeSideboard()

func _process(_delta):
	# Regenerates all loose tiles and resets their position.
	if Input.is_action_just_pressed("Reset"):
		resetLoose()
	
	if Input.is_action_just_pressed("Grab or Let go"):
		if !heldPolyomino == null:
			letGo.emit(heldPolyomino)
			get_tree().call_group("{node}-polyominoTiles".format({"node":heldPolyomino}),
								  "addZ", -20)
			heldPolyomino = null
		elif !leftClickedOn.size() == 0:
			heldPolyomino = leftClickedOn[0]
			get_tree().call_group("{node}-polyominoTiles".format({"node":heldPolyomino}),
								  "addZ", 20)
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
	for number in range(tileNumber):
		var newPolyomino = makePolyomino()
		newPolyomino.position += Vector2(tileHeight*newPolyomino.widthTiles/2 + offsetX,
										 tileHeight*newPolyomino.heightTiles/2 + offsetY)
		offsetY += (newPolyomino.heightTiles+1)*tileHeight

func makePolyomino():
	var newPolyomino = polyomino.instantiate()
	add_child(newPolyomino)
	newPolyomino.init(tileHeight)
	polyominos[newPolyomino] = true
	var zIndex = 2
	for anyPolyomino in polyominos.keys():
		get_tree().call_group("{node}-polyominoTiles".format({"node":anyPolyomino}),
							  "setZ", zIndex)
		zIndex += 1
	return newPolyomino

func resetLoose():
	heldPolyomino = null
	for activePolyomino in polyominos.keys():
		polyominos.erase(activePolyomino)
		activePolyomino.queue_free()
	makeSideboard()

func onLeftClick(clickedPolyomino):
	leftClickedOn.append(clickedPolyomino)

func onRightClick(clickedPolyomino):
	rightClickedOn.append(clickedPolyomino)
