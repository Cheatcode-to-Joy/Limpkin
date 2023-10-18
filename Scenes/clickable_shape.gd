extends CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var polyomino = get_parent().get_parent()
	sizeChanged(polyomino.actualWidth, polyomino.actualHeight)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func sizeChanged(width, height):
	self.scale = Vector2(width, height)
