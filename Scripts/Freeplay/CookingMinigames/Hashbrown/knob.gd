extends Area2D
var hold = false
var ogPos=position


func _process(_delta: float) -> void:
	if hold:
		position.y = lerp(position.y, get_global_mouse_position().y, 0.2)
	else:
		position.y = lerp(position.y, ogPos.y, 0.05)

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			hold = true
			if not event.pressed:
				hold = false


func _on_area_entered(area: Area2D) -> void:
	if area.name=="end":
		ogPos=area.position
