extends Node2D

var beeScene
var bee = null

var terrainScene
var terrainType = null
var terrainOptions = ["Forest","Lake","Meadow","Mountain"]

func _ready():
	beeScene = preload("res://Scenes/Tiles/bumblesheep.tscn")
	terrainScene = preload("res://Scenes/Tiles/terrain.tscn")

func init(addingTerrain="Random",addingBee=false):
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
		terrainType = terrainOptions[randi() % (terrainOptions.size())]
	get_child(0).texture = load("res://Assets/Textures/Terrain{terrain}.png"
								.format({"terrain":terrainType}))

func _process(_delta):
	pass
