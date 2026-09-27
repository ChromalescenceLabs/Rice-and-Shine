extends Area2D

var mouse_velocity

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if not event.pressed:
				var current_velocity = Input.get_last_mouse_velocity().x
				
				if abs(current_velocity) > 2000:
					print(current_velocity)
		
