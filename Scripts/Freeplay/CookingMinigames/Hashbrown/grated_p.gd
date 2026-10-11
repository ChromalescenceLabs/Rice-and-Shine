extends Area2D
var hold = false
var ogPos=position
var hasBeenPut=false

func _ready() -> void:
	visible=false

func _process(_delta: float) -> void:
	if hold:
		visible=true
		global_position = lerp(global_position, get_global_mouse_position(), 0.2)
	else:
		visible=falsea
		global_position = lerp(global_position, ogPos, 0.05)

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			hold = true
			if not event.pressed:
				hold = false

func _on_area_entered(area: Area2D) -> void:
	if area.name="bowl":
