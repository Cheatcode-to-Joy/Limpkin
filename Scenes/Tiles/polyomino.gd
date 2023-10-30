extends Node2D

var tileScene
var tileArea
var tileHeight
var tiles = {}

var sizeMultiplier : float = 7.0/3.0

var widthTiles : float = 0
var heightTiles : float = 0 

signal changedSize(width, height)

func _ready():
	tileScene = preload("res://Scenes/Tiles/tile_square.tscn")
	tileArea = preload("res://Scenes/Tiles/tile_area.tscn")

func init(givenTileHeight,width:float=4,height:float=4):
	tileHeight = givenTileHeight
	var newArea = tileArea.instantiate()
	add_child(newArea)
	changedSize.connect(newArea.sizeChanged)
	makeValidPolyomino(width,height)
	changedSize.emit(widthTiles*tileHeight,heightTiles*tileHeight)

func _process(_delta):
	pass

func makeValidPolyomino(maxWidth,maxHeight):
	# Instancing dictionaries. 
	# tileDictionary = All possible tiles within the polyomino.
	# 	-1 = confirmed empty, 0 = empty, 1 = tile, 2 = tile+symbol
	# candidateCoordinates = Current tiles to consider for ascension.
	var tileDictionary = {}
	var candidateCoordinates = {}
	for row in range(maxHeight):
		for column in range(maxWidth):
			tileDictionary[[row,column]] = 0
	
	# The starting point is top left for simplicity.
	candidateCoordinates[[0,0]] = true
	
	while !(candidateCoordinates.keys() == []):
		for candidate in candidateCoordinates.keys():
			if tileDictionary[candidate] == 0 and \
			randf() >= sizeMultiplier*(tiles.keys().size()/(maxWidth*maxHeight)):
				# Accounting for the new tile and writing down its coordinates.
				var newTile = tileScene.instantiate()
				tiles[newTile] = Vector2(candidate[0],candidate[1])
				newTile.add_to_group("{node}-polyominoTiles".format({"node":self}))
				add_child(newTile)
				
				# Updating the size of the polyomino.
				widthTiles = max(widthTiles, candidate[0]+1)
				heightTiles = max(heightTiles, candidate[1]+1)
				
				# Adding tiles directly to the right or bottom to candidates.
				if candidate[0] < maxWidth-1:
					candidateCoordinates[[candidate[0]+1,candidate[1]]] = true
				if candidate[1] < maxHeight-1:
					candidateCoordinates[[candidate[0],candidate[1]+1]] = true
			else:
				# If failed, candidate no longer eligible.
				tileDictionary[candidate] = -1
			candidateCoordinates.erase(candidate)
	
	for newTile in tiles.keys():
		newTile.init()
		newTile.position = Vector2(tileHeight*(tiles[newTile][0]-(widthTiles/2)),
								   tileHeight*(tiles[newTile][1]-(heightTiles/2)))
		newTile.position += Vector2(tileHeight/2,tileHeight/2)
	
	# Giving a random number of tiles a bee.
	var randomTiles = tiles.keys()
	randomTiles.shuffle()
	@warning_ignore("narrowing_conversion")
	var beeTileNumber = randi_range(randomTiles.size()*0.3,randomTiles.size()*0.45)
	for tile in range(beeTileNumber):
		randomTiles[tile].addBee()

func rotatePolyomino(times=1):
	for occurence in range(times):
		for tile in tiles.keys():
			tiles[tile] = Vector2(tiles[tile][1],tiles[tile][0])
		global_rotation_degrees += 90
		for tile in tiles.keys():
			tile.global_rotation_degrees -= 90
