extends Node2D
signal faucet_done

func _on_water_progress_bar_value_changed(value: float) -> void:
	if value >= 100: faucet_done.emit()
