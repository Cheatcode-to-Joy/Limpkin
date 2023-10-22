extends Node2D

var beeScene
var bee = null

var terrainScene
var terrainType = null
var terrainOptions = ["forest","lake","meadow","mountain"]

func _ready():
	beeScene = preload("res://Scenes/Tiles/bumblesheep.tscn")
	terrainScene = preload("res://Scenes/Tiles/terrain.tscn")

func init(addingTerrain="meadow",addingBee=false):
	addTerrain(addingTerrain)
	if addingBee:
		addBee()

func addBee():
	bee = beeScene.instantiate()
	add_child(bee)

func addTerrain(addingTerrain):
	if addingTerrain in terrainOptions:
		terrainType = addingTerrain
	else:
		terrainType = "meadow"

func _process(_delta):
	pass
