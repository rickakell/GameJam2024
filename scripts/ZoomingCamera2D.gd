extends Camera2D

static var zoomed := Vector2(4, 4)
static var unzoomed := Vector2(1.0, 1.0)
var initial_position := position

func _unhandled_input(event):
	if event.is_action("zoom_in") and not event.is_echo():
		if event.is_pressed():
			zoom = zoomed
			position = get_viewport().get_mouse_position()
		if event.is_action_released("zoom_in"):
			zoom = unzoomed
			position = initial_position
