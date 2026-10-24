@tool
extends Container

@export var spacing: float = 120.0:
	set(value):
		spacing = value
		queue_sort()

@export var diagonal_vector: Vector2 = Vector2(1.0,1.0):
	set(value):
		diagonal_vector = value.normalized()
		queue_sort()

func _notification(what: int) -> void:
	if what == NOTIFICATION_SORT_CHILDREN:
		update_layout()

func update_layout():
	var n = get_children()
	for i in n.size():
		var base_pos = diagonal_vector * (i * spacing)
		var target_pos = base_pos - (diagonal_vector)
		
		fit_child_in_rect(n[i], Rect2(target_pos, n[i].get_minimum_size()))
	
