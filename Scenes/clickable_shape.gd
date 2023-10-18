extends CollisionShape2D

var multiplier : float = 2.5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func sizeChanged(width, height):
	self.scale = Vector2(multiplier*width, multiplier*height)
