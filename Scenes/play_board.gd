extends Node2D

var gameWidth
var gameHeight

var tileScene
var tileHeight

var boardWidth = 8
var boardHeight = 8

var tiles = {}

func _ready():
	updateGameSize(get_tree().root.get_child(0).gameWidth,get_tree().root.get_child(0).gameHeight)
	
	tileScene = preload("res://Scenes/Tiles/tile_square.tscn")
	tileHeight = get_parent().tileHeight
	position += Vector2(gameWidth-tileHeight*(1+boardWidth/2.0),tileHeight*(1+boardHeight/2.0))

func _process(_delta):
	pass

func makeBoard():
	tiles = {}
	for row in range(boardHeight):
		for column in range(boardWidth):
			var newTile = tileScene.instantiate()
			newTile.init("Basic",false,true)
			add_child(newTile)
			newTile.position = Vector2(tileHeight*(.5+column-boardWidth/2.0),
									   tileHeight*(.5+row-boardHeight/2.0))
			newTile.modulate.a = 0.5
			tiles[newTile] = Vector2(tileHeight*row,tileHeight*column)

func slotPolyomino(slottingPolyomino):
	var polyominoTiles = slottingPolyomino.tiles
	
	var possibleSlots = {}
	
	for polyominoTile in polyominoTiles.keys():
		for boardTile in tiles.keys():
			if boardTile.terrainType != "Basic":
				continue
			if (abs(polyominoTile.global_position.x - boardTile.global_position.x) <= tileHeight/2 and 
				abs(polyominoTile.global_position.y - boardTile.global_position.y) <= tileHeight/2):
				possibleSlots[polyominoTile] = boardTile
		if polyominoTile not in possibleSlots.keys():
			return
	
	for slotTile in possibleSlots.keys():
		possibleSlots[slotTile].init(slotTile.terrainType,true if slotTile.bee != null else false,false)
		possibleSlots[slotTile].modulate.a = 1
	get_parent().polyominos.erase(slottingPolyomino)
	slottingPolyomino.queue_free()

func updateGameSize(width,height):
	gameWidth = width
	gameHeight = height
