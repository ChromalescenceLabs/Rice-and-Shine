extends PointLight2D

@export var turn_on_hour: float = 19.0
@export var turn_off_hour: float = 8.0

func _process(_delta: float) -> void:
	var manager = get_tree().get_first_node_in_group("day_night_cycle")
	if manager:
		manager.time_tick.connect(_on_time_tick)

func _on_time_tick(_day: int, hour: int, _minute:int) -> void:
	_check_light_state(hour)

func _check_light_state(current_hour: int) -> void:
	if turn_on_hour > turn_off_hour:
		enabled = current_hour >= turn_on_hour or current_hour < turn_off_hour
	else:
		enabled = current_hour >= turn_on_hour and current_hour < turn_off_hour
