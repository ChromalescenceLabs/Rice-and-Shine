extends Node2D

func _ready() -> void:
	set_process_input(false)
	set_process(false)

func _process(_delta: float) -> void:
	self.global_position = lerp(self.global_position, get_global_mouse_position() + Vector2(0, -30), 0.2)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"):
		set_process(true)
	elif event.is_action_released("Click"):
		set_process(false)
		
func _on_pickable_area_mouse_entered() -> void:
	set_process_input(true)

func _on_pickable_area_mouse_exited() -> void:
	set_process_input(false)
