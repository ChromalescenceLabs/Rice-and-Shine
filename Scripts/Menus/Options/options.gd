extends Button
const OPTIONS_MENU = preload("uid://bqihwymm5632x")
@onready var canvas_layer: CanvasLayer = $"../CanvasLayer"

func _on_pressed() -> void:
	var opt = OPTIONS_MENU.instantiate()
	canvas_layer.add_child(opt)
