extends Area2D

signal startGame()

func _ready():
	scale = Vector2(45,20)
	startGame.connect(get_tree().root.get_child(0).gameStart)

func _process(_delta):
	pass

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			startGame.emit()
