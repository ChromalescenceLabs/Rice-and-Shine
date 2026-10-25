extends Control
var hovering := false
var dragging := false
var og_pos : Vector2
var snap_to_og_pos := false

func _ready() -> void:
	og_pos  = self.global_position

func _process(_delta: float) -> void:
	if dragging: self.global_position = lerp(self.global_position, get_global_mouse_position(), 0.2)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"): if hovering: dragging = true
	elif event.is_action_released("Click"): 
		if hovering: 
			dragging = false
			if snap_to_og_pos:
				self.global_position = og_pos

func _on_cooking_bowl_texture_mouse_entered() -> void: hovering = true
func _on_cooking_bowl_texture_mouse_exited() -> void: hovering = false
