extends VBoxContainer

var day = 1

func  _ready() -> void:
	for child in get_children():
		if child is Button:
			print(child)
			var index = get_children().find(child)
			if index>day:
				var locked = ColorRect.new()
				child.add_child(locked)
				locked.color=Color(0.0, 0.0, 0.0, .6)
				locked.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
				child.set_disabled(true)
