extends Container

@onready var weeks: Array = [$WeekOne, $WeekTwo, $WeekThree, $WeekFour, $WeekFive, $WeekSix, $WeekSeven]
var current_index: int = 0


func _ready() -> void:
	for i in range(weeks.size()):
		_update_shader(i, false)
	if weeks.size() > 0:
		_update_shader(0,true)
#when scene starts, all have no shaders except week one

func _update_shader(index: int, enable:bool) -> void:
	var selected_week = weeks[index]
	if selected_week and selected_week.material:
		selected_week.material.set_shader_parameter("enable_shader", enable)
	if enable:
		selected_week.modulate = Color.WHITE
	else: 
		selected_week.modulate = Color(0.332, 0.316, 0.292, 1.0)

func _on_back_pressed() -> void:
	if weeks.size() <= 1:
		return
	_update_shader(current_index, false)
	current_index = (current_index + 1) % weeks.size()
	
	_update_shader(current_index, true)

func _on_forward_pressed() -> void:
	if weeks.size() <= 1:
		return
	_update_shader(current_index, false)
	current_index = (current_index - 1 + weeks.size()) % weeks.size()
	
	_update_shader(current_index, true)
	
	
	
