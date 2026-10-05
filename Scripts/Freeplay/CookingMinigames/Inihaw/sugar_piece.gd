extends Area2D

var in_bowl: bool = false

func _process(_delta: float) -> void:
		self.global_position = lerp(self.global_position, get_global_mouse_position(), 0.2)
		
func _input(event: InputEvent) -> void:
	if event.is_action_released("Click"):
		if in_bowl:
			get_tree().current_scene.sugar_no += 1
		
		self.queue_free()
	
func _on_area_entered(area: Area2D) -> void:
	if area is BowlFillArea:
		in_bowl = true

func _on_area_exited(area: Area2D) -> void:
	if area is BowlFillArea:
		in_bowl = false
