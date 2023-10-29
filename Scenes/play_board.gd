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
			tiles[newTile] = Vector2(tileHeight*row,tileHeight*column)

func slotPolyomino(heldPolyomino):
	var polyominoCenter = heldPolyomino.position
	var polyominoTiles = heldPolyomino.tiles
	
	var possibleSlots = {}
	var canSlot = true
	
	for polyominoTile in polyominoTiles.keys():
		var tileCenter = polyominoCenter + polyominoTiles[polyominoTile]
		for boardTile in tiles.keys():
			if boardTile.terrainType != "Basic":
				continue
			if (abs(polyominoTile.global_position.x - boardTile.global_position.x) <= tileHeight/2 and 
				abs(polyominoTile.global_position.y - boardTile.global_position.y) <= tileHeight/2):
				possibleSlots[polyominoTile] = boardTile
		if polyominoTile not in possibleSlots.keys():
			canSlot = false
			break
		print(possibleSlots)
	
	if canSlot:
		for slotTile in possibleSlots.keys():
			possibleSlots[slotTile].init(slotTile.terrainType,true if slotTile.bee != null else false,false)
			possibleSlots[slotTile].modulate.a = 1
		get_parent().polyominos.erase(heldPolyomino)
		heldPolyomino.queue_free()
