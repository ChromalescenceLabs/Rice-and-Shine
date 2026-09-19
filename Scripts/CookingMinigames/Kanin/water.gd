extends GPUParticles2D

signal WaterCompleted

@onready var water_detect: Area2D = $WaterDetect
@onready var water_progress_bar: ProgressBar = $"../WaterProgressBar"
@onready var progress_bar_change_time: Timer = $"../WaterProgressBar/ProgressBarChangeTime"

func _ready() -> void:
	emitting = false

func _on_finished() -> void:
	water_detect.monitoring = false

func _on_water_detect_area_entered(area: Area2D) -> void:
	if area is BowlFillArea:
		progress_bar_change_time.start()

func _on_water_detect_area_exited(area: Area2D) -> void:
	if area is BowlFillArea:
		progress_bar_change_time.stop()

func _on_rice_or_kanin_water_section() -> void:
	pass

func _on_close_pressed() -> void:
	emitting = false
	await get_tree().create_timer(1.0).timeout
	water_detect.monitoring = false
	
	if water_progress_bar.value < 75 and water_progress_bar.value > 60:
		WaterCompleted.emit()

func _on_open_pressed() -> void:
	emitting = true
	await get_tree().create_timer(1.0).timeout
	water_detect.monitoring = true

func _on_progress_bar_change_time_timeout() -> void:
	water_progress_bar.value += 0.3
