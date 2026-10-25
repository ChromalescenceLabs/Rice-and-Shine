@tool
extends Container
#idfk what the HELL im doing
@export var base_font: int = 60:
	set(value):
		base_font = value
		queue_sort()
		
@export var selection_font: int = 8:
	set(value):
		selection_font = value
		queue_sort()

@export var font_dec: int = 4:
	set(value):
		font_dec = value
		queue_sort()

@export var spacing: int = 8:
	set(value):
		spacing = value
		queue_sort()
		
func _notification(what: int) -> void:
	if what == NOTIFICATION_SORT_CHILDREN:
		update_layout()

func update_layout():
	var current_y: float = 0.0
	var vis_index: int = 0

	for child in get_children():
		if not child is Control or not child.visible:
			continue
		var font_size: int = base_font - (vis_index * font_dec)
		
		if child is Button:
			if child.has_focus() or child.is_hovered():
				font_size += selection_font
		font_size = max(12, font_size)
		child.add_theme_font_override("font_size",font_size)
		
		var child_min_size: Vector2 = child.get_combined_minimum_size()
		var child_rect: Rect2 = Rect2(0, current_y, size.x,child_min_size.y)
		
		fit_child_in_rect(child, child_rect)
		current_y += child_min_size.y + spacing
		vis_index += 1
		
func _child_entered_tree(Child: Node) -> void:
	if child is Button:
		if not child.focus_entered.is_connected(queue_sort:
			child.focus_entered.connect(queue_sort)
