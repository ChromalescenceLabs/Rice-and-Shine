extends Node2D
const SUGAR_PIECE = preload("uid://cwi7ud17itmbg")
var is_hovering: bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"):
		if is_hovering:
			var sp = SUGAR_PIECE.instantiate()
			sp.global_position = get_global_mouse_position()
			add_child(sp)

func _on_sugar_mouse_entered() -> void: is_hovering = true
func _on_sugar_mouse_exited() -> void: is_hovering = false
