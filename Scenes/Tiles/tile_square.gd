extends Node2D

var beeScene
var bee = null

var terrainScene
var terrainType = null
var terrainOptions = ["Forest","Lake","Meadow","Mountain"]

var isShadow = false

func _ready():
	beeScene = preload("res://Scenes/Tiles/bumblesheep.tscn")
	terrainScene = preload("res://Scenes/Tiles/terrain.tscn")

func init(addingTerrain="Random",addingBee=false,addingShadow=false):
	addTerrain(addingTerrain)
	if addingBee:
		addBee()
	isShadow = addingShadow

func addBee():
	bee = beeScene.instantiate()
	add_child(bee)

func addTerrain(addingTerrain):
	if addingTerrain in terrainOptions or addingTerrain == "Basic":
		terrainType = addingTerrain
	else:
		terrainType = terrainOptions[randi() % (terrainOptions.size())]
	get_child(0).texture = load("res://Assets/Textures/Terrain{terrain}.png"
								.format({"terrain":terrainType}))

func _process(_delta):
	pass

func addZ(Zamount):
	get_child(0).z_index += Zamount
	if (get_child_count() >= 2):
		get_child(1).get_child(0).z_index += Zamount

func setZ(Zamount):
	get_child(0).z_index = Zamount
	if (get_child_count() >= 2):
		get_child(1).get_child(0).z_index = Zamount
