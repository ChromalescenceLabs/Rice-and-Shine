extends VBoxContainer

@onready var tutorial: Button = $TUTORIAL
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
			child.set_disabled(false)
			var index = get_children().find(child)
			if index > day + 1:
				if not locked or not is_instance_valid(locked):
					locked = ColorRect.new()
					locked.color = Color(0.0, 0.0, 0.0, 0.6)
					locked.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
					child.add_child(locked)
					
				#if locked.get_parent(): locked.reparent(child)
				#else: child.add_child(locked)
				
				if locked.get_parent(): locked.reparent(child)
				child.set_disabled(true)


func _on_weeks_change_week(current_week) -> void:
	var number= current_week.name.to_lower().substr(4, -1)
	if number == "one" and is_instance_valid(tutorial): tutorial.visible = true
	else: if is_instance_valid(tutorial): tutorial.visible = false
	
	match number:
		"one":
			if not GlobalVars.tutorial_finished: day = 0
			else: day = GlobalVars.w1_days
			changeDays()
		"two":
			day = GlobalVars.w2_days
			changeDays()
		"three":
			day = GlobalVars.w3_days
			changeDays()
		"four":
			day = GlobalVars.w4_days
			changeDays()
		"five":
			day = GlobalVars.w5_days
			changeDays()
		"six":
			day = GlobalVars.w6_days
			changeDays()
		"seven":
			day = GlobalVars.w7_days
			changeDays()
