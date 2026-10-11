extends Sprite2D
#THIS IS NOT FUNCTIONAL OK
@onready var week_one: Sprite2D = $"."
@onready var label: Label = $Label


func _on_label_mouse_entered() -> void:
	label.text = "hi hello"
	
func _on_label_mouse_exited() -> void:
	label.text = "ok bye bye"
