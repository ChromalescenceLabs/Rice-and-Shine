extends Area2D
var hold = false
var ogPos=position

func _process(_delta: float) -> void:
	if hold:
		global_position = lerp(global_position, get_global_mouse_position(), 0.2)
	else:
		global_position = lerp(global_position, ogPos, 0.05)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("Click"):
		hold=true
	
	if event.is_action_released("Click"):
		hold=false
