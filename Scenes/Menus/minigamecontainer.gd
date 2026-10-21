@tool
extends Container

@export var radius: float = 100.0:
	set(value):
		radius = value; queue_sort()

@export var counter_clockwise: bool:
	set(value):
		counter_clockwise = value; queue_sort()

func _notification(what: int) -> void:
	if what == NOTIFICATION_SORT_CHILDREN:
		update_layout()

func update_layout():
	var n = get_child_count()
	var angle_step = 2.0 * PI / float(n)
	for i in n:
		var c = get_child(i)
		var a = i * angle_step
		if counter_clockwise:
			a = 2.0 * PI - a
		fit_child_in_rect(c, Rect2(radius * Vector2(cos(a), sin(a)) - c.size / 2.0, Vector2.ZERO))
