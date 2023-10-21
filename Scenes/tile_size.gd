extends CollisionShape2D

var polyomino

func _ready():
	polyomino = get_parent().get_parent()

func _process(delta):
	pass

func sizeChanged(width, height):
	scale = Vector2(width/20.0, height/20.0)
	print(scale)
