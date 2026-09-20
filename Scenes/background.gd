extends Sprite2D

func _process(delta):
	var mouse_pos = get_local_mouse_position()
	position += (mouse_pos*delta)-position
