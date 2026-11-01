extends VBoxContainer

@onready var tutorial: Button = $TUTORIAL
@onready var dayone: Button = $DAYONE
@onready var daytwo: Button = $DAYTWO
@onready var daythree: Button = $DAYTHREE
@onready var dayfour: Button = $DAYFOUR
@onready var dayfive: Button = $DAYFIVE
@onready var daysix: Button = $DAYSIX
@onready var dayseven: Button = $DAYSEVEN
var day = 1
var locked

func  _ready() -> void:
	tutorial.scene = "uid://dsklae1f304tw"
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
			change_button_outputs("uid://rbbhbjtbvlt3", "uid://k2tybwu53u8d", "uid://e3qdmyi5kend", "uid://d3arbpd44b1pl", "uid://dfetwqse3d3yr", "uid://c75yia37ddx7x", "uid://c17ktklpdhftd")
			changeDays()
		"two":
			day = GlobalVars.w2_days
			change_button_outputs("uid://rbbhbjtbvlt3", "uid://k2tybwu53u8d", "uid://e3qdmyi5kend", "uid://d3arbpd44b1pl", "uid://dfetwqse3d3yr", "uid://c75yia37ddx7x", "uid://c17ktklpdhftd")
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

func change_button_outputs(day1 : String, day2 : String, day3 : String, day4 : String, day5 : String, day6 : String, day7 : String):
	if is_instance_valid(dayone): dayone.scene = day1
	if is_instance_valid(daytwo): daytwo.scene = day2
	if is_instance_valid(daythree): daythree.scene = day3
	if is_instance_valid(dayfour): dayfour.scene = day4
	if is_instance_valid(dayfive): dayfive.scene = day5
	if is_instance_valid(daysix): daysix.scene = day6
	if is_instance_valid(dayseven): dayseven.scene = day7
