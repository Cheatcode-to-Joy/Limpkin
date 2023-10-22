extends Area2D

var polyomino
var board

signal leftClick(polyomino)
signal rightClick(polyomino)

func _ready():
	polyomino = get_parent()
	board = polyomino.get_parent()
	leftClick.connect(board.onLeftClick)
	rightClick.connect(board.onRightClick)

func _process(_delta):
	pass

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			leftClick.emit(polyomino)
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			rightClick.emit(polyomino)
