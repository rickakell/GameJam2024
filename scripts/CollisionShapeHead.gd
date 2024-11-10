extends Area2D

func _input_event(viewport, event, shape_index):
	if event.is_action("shoot"):
		print("bang!")
