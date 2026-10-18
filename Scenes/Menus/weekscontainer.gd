@tool
extends Container

func _ready() -> void:
	$WeekOne.material.set_shader_parameter("enable_shader", true)

func _on_back_pressed() -> void:
	$WeekOne.material.set_shader_parameter("enable_shader", false)
	
func _on_forward_pressed() -> void:
	$WeekOne.material.set_shader_parameter("enable_shader", false)

	
