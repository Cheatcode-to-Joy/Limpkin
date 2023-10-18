extends Node2D

var actualWidth = 0
var actualHeight = 0
var centerX : float = actualWidth
var centerY : float = actualHeight
var grabbed = false
var firstMousePosition = Vector2(0,0)
var grabPosition = self.position

# tileDictionary = All possible tiles within the polyomino.
#   -1 = confirmed empty, 0 = empty, 1 = tile, 2 = tile+symbol
var tileDictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if grabbed:
		self.position = get_viewport().get_mouse_position()

func init(width=4, height=4, inputMatrix=[], symbolMatrix=[]):
	return makeValidPolyomino(width, height)

func makeValidPolyomino(width, height):
	# Instancing dictionaries. 
	# tileCandidates = Current tiles to consider for ascension.
	var tileCandidates = {}
	for row in range(height):
		for column in range(width):
			tileDictionary[[row,column]] = 0
	
	# The starting point is top left for simplicity.
	tileCandidates[[0,0]] = true
	
	var filled: float = 0
	while !(tileCandidates.keys() == []):
		for candidate in tileCandidates.keys():
			if ((tileDictionary[candidate] == 0) and
				(randf() >= 7*filled/(3*width*height))):
				tileDictionary[candidate] = 1
				actualWidth = max(actualWidth, candidate[0])
				actualHeight = max(actualHeight, candidate[1])
				filled += 1
				if !(candidate[0] >= width-1):
					tileCandidates[[candidate[0]+1,candidate[1]]] = true
				if !(candidate[1] >= height-1):
					tileCandidates[[candidate[0],candidate[1]+1]] = true
			else:
				tileDictionary[candidate] = -1
			tileCandidates.erase(candidate)
	return tileDictionary

func rotatePolyomino(times=1):
	for occurence in range(times):
		var newTileDictionary = {}
		for tile in tileDictionary.keys():
			newTileDictionary[[tile[1],tile[0]]] = tileDictionary[tile]
		tileDictionary = newTileDictionary
		var rotationPoint = get_viewport().get_mouse_position()
		global_rotation_degrees += 90

func onLeftClick():
	firstMousePosition = Vector2(0,0) if grabbed else get_viewport().get_mouse_position()
	if grabbed:
		grabPosition = self.position
	grabbed = !grabbed
	
func onRightClick():
	rotatePolyomino()
