extends Area2D

var in_wrap : bool = false


func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event.is_action_released("Click"):
		if in_wrap:
			get_parent().wrap_filled.emit()
		
		queue_free()

func _process(_delta: float) -> void:
	self.global_position = lerp(self.global_position, get_global_mouse_position(), 0.2)


func _on_area_entered(area: Area2D) -> void:
	if area is Wrap: in_wrap = true

func _on_area_exited(area: Area2D) -> void:
	if area is Wrap: in_wrap = false
