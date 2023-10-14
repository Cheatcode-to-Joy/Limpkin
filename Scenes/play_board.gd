extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var screenWidth = get_viewport().size.x
	var screenHeight = get_viewport().size.y
	var tile = load("res://Scenes/tile_square.tscn")
	var bbee = load("res://Scenes/bumblesheep.tscn")
	for i in range(8):
		for j in range(8):
			var tileInstance = tile.instantiate()
			var bbeeInstance = bbee.instantiate()
			tileInstance.position = Vector2((5*screenWidth/6)+100*i, (screenHeight/10)+100+100*j)
			add_child(tileInstance)
			tileInstance.add_child(bbeeInstance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
