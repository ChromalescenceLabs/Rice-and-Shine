extends VBoxContainer

var day = 1
var locked

func  _ready() -> void:
	changeDays()
func changeDays():
	if locked and is_instance_valid(locked):
		if locked.get_parent():
			locked.get_parent().remove_child(locked)

	for child in get_children():
		if child is Button:
			print(child)
			child.set_disabled(false)
			var index = get_children().find(child)
			if index > day:
				if not locked or not is_instance_valid(locked):
					locked = ColorRect.new()
					locked.color = Color(0.0, 0.0, 0.0, 0.6)
					locked.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
				
				child.add_child(locked)
				child.set_disabled(true)


func _on_weeks_change_week(current_week) -> void:
	var number= current_week.name.to_lower().substr(4, -1)
	match number:
		"one":
			day=5
			changeDays()
		"two":
			day=2
			changeDays()
		"three":
			day=6
			changeDays()
		"four":
			day=3
			changeDays()
		"five":
			day=1
			changeDays()
		"six":
			day=7
			changeDays()
		"seven":
			day=8
			changeDays()
