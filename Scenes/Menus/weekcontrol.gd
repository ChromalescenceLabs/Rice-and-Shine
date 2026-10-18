extends Control

@export_range(0.0, 360.0, 1.0, "degrees") var min_rotation: float = 0.0
@export_range(0.0, 360.0, 1.0, "degrees") var max_rotation: float = 360.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pivot_offset = size / 2
	
	var randpos = randf_range(min_rotation,max_rotation)
	rotation_degrees = randpos
