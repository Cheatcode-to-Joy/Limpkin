extends Node2D

var beeScene
var bee = null

var terrainScene
var terrainType = null
var terrainOptions = ["forest","lake","meadow","mountain"]

func _ready():
	beeScene = preload("res://Scenes/bumblesheep.tscn")
	terrainScene = preload("res://Scenes/terrain.tscn")

func init(addTerrain="meadow",addBee=false):
	addTerrain(addTerrain)
	if addBee:
		addBee()

func addBee():
	bee = beeScene.instantiate()
	add_child(bee)

func addTerrain(addTerrain):
	if addTerrain in terrainOptions:
		terrainType = addTerrain
	else:
		terrainType = "meadow"

func _process(delta):
	pass
