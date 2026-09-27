extends TextureRect

const STICK_COMPS = preload("uid://brd3lmuj2umok")
var touching: bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click") and touching:
		var stick_comps = STICK_COMPS.instantiate()
		stick_comps.type = "Hotdog"
		add_child(stick_comps)

func _on_mouse_entered() -> void: touching = true

func _on_mouse_exited() -> void: touching = false
