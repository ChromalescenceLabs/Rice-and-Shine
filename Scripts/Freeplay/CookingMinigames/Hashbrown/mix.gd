extends Node2D
@onready var mixer: Area2D = $mixer

func _on_mixer_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("Click"):
			mixer.hold = true
			mixer.set_process(true)
	if event.is_action_released("Click"):
			mixer.hold = false
