extends TextureRect
var is_hovering : bool = false
const EGG = preload("uid://c3xdcqpla8eix")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"):
		if is_hovering:
			var egg = EGG.instantiate()
			egg.global_position = get_global_mouse_position()
			add_child(egg)
			self.mouse_filter = Control.MOUSE_FILTER_IGNORE
			
			await egg.tree_exited
			if not get_tree().current_scene.cracked_egg_amt == 2:
				self.mouse_filter = Control.MOUSE_FILTER_PASS
			
func _on_mouse_entered() -> void: is_hovering = true
func _on_mouse_exited() -> void: is_hovering = false
