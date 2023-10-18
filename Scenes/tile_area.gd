extends Area2D

signal leftClick
signal rightClick

# Called when the node enters the scene tree for the first time.
func _ready():
	var polyomino = get_parent().get_parent()
	self.leftClick.connect(polyomino.onLeftClick)
	self.rightClick.connect(polyomino.onRightClick)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			leftClick.emit()
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			rightClick.emit()
