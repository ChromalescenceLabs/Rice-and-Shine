@tool
extends Container

@export var spacing: float = 120.0:
	set(value):
		spacing = value
		queue_sort()

@export var total_height: float = 400.0:
	set(value):
		total_height = value
		queue_sort()

@export var curve_amp: float = 150.0:
	set(value):
		curve_amp = value
		queue_sort()

func _notification(what: int) -> void:
	if what == NOTIFICATION_SORT_CHILDREN:
		update_layout()

func update_layout():
	var children = get_children().filter(func(c): return c is Control and c.visible)
	var child_count = children.size()
	
	if child_count == 0:
		return
		
	if child_count == 1:
		var child = children[0]
		var target_pos = Vector2(0, total_height - child.get_minimum_size().y / 2.0)
		fit_child_in_rect(child, Rect2(target_pos, child.get_minimum_size()))
		return
	
	for i in range(child_count):
		var child = children[i]
		var min_size = child.get_minimum_size()
		
		var t = float(i) / float (child_count - 1)
		var y_pos = (t * total_height) - (min_size.y / 2.0)
		
		sin(PI * 0)
		sin(PI * 0.5)
		sin(PI * 1)
		var x_offset = sin(t * PI) * curve_amp
		
		var x_pos = x_offset - (min_size.x / 2.0)
		var target_pos = Vector2(x_pos, y_pos)
		
		fit_child_in_rect(child, Rect2(target_pos, min_size))
