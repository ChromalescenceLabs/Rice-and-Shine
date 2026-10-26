extends Node2D
signal faucet_done
@onready var water: GPUParticles2D = $Water
@onready var water_detect: Area2D = $Water/WaterDetect

func _on_water_progress_bar_value_changed(value: float) -> void:
	if value >= 100: 
		faucet_done.emit()
		water.emitting = false
		water_detect.monitorable = false
		water_detect.monitoring = false
