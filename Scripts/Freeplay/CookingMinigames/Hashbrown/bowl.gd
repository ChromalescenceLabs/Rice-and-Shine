extends Area2D
@onready var potato: Area2D = $"../potato"

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("Click"):
		potato.visible=true
		potato.hold = true

func _on_potato_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_released("Click"):
		potato.visible=false
		potato.hold = false
