extends Camera2D

@export var max_offset: Vector2 = Vector2(60, 25)
@export var smooth_speed: float = 10.0
var center: Vector2

func _ready() -> void:
	center = global_position
	
func _process(delta: float) -> void:
	var vps : Vector2 = get_viewport().get_visible_rect().size
	
	var mouse_pos : Vector2 = get_viewport().get_mouse_position()
	var norm_mouse : Vector2 = (mouse_pos / vps) - Vector2(0.5, 0.5)
	
	var target : Vector2 = center + (norm_mouse * max_offset)
		
	global_position = global_position.lerp(target, smooth_speed * delta)
