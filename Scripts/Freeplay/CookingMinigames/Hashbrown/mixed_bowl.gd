extends Area2D
@onready var mold: Area2D = $"../mold"

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("Click"):
		mold.hold=true
		mold.visible=true
		mold.set_process(true)

func _on_mold_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_released("Click"):
		mold.hold=false
		mold.visible=false
