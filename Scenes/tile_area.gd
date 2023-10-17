extends Area2D

signal click

# Called when the node enters the scene tree for the first time.
func _ready():
	var polyomino = get_parent().get_parent()
	self.click.connect(polyomino.onClick)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.is_pressed():
		click.emit()
