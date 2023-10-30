extends Node2D

func _ready():
	scale = Vector2(45,20)

func _process(_delta):
	pass

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
			get_tree().quit()
