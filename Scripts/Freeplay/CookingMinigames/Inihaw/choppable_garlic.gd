extends Area2D

signal slice
signal chopped_garlic_finished

@onready var progress_bar: ProgressBar = $ProgressBar
var passed_through: bool = false
var mouse_hold: bool = false
var slices: int = 0

func _ready() -> void:
	progress_bar.modulate.a = 0

func _on_detector_mouse_entered() -> void: passed_through = true
func _on_detector_mouse_exited() -> void: if not mouse_hold: passed_through = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			mouse_hold = true
			if not event.pressed:
				mouse_hold = false
				var current_velocity_x = Input.get_last_mouse_velocity().x
				var current_velocity_y = Input.get_last_mouse_velocity().y
				
				if (abs(current_velocity_x) > 1000 or abs(current_velocity_y) > 1000) and passed_through:
					slice.emit()
				
				passed_through = false

func _on_slice() -> void:
	slices += 1
	
	progress_bar.value = slices * 10
	
	if progress_bar.value >= 100:
		GlobalVars.successind(get_tree().current_scene)
		await GlobalVars.successIndEnd
		
		chopped_garlic_finished.emit()

func progbar_fade_in():
	create_tween().tween_property(progress_bar, "modulate:a", 1, 0.3).set_trans(Tween.TRANS_CUBIC)
