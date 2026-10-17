extends Area2D

@onready var pan_empty: Sprite2D = $Pan
@onready var pan_oiled: Sprite2D = $PanOil
@onready var progress_bar_change_time: Timer = $"../ProgressBar/ProgressBarChangeTime"
@onready var progress_bar: ProgressBar = $"../ProgressBar"
@onready var grated: TextureRect = $Grated

var has_hdog: bool = false
var has_oil: bool = false

func oiled() -> void:
	has_oil = true
	pan_oiled.visible = true
	pan_empty.visible = false

func unoil() -> void:
	has_oil = false
	pan_empty.visible = true
	pan_oiled.visible = false

func _on_grated_visibility_changed() -> void:
	progress_bar_change_time.start()

func _on_progress_bar_change_time_timeout() -> void:
	if progress_bar.value<100:
		progress_bar.value+=1
		grated.modulate = grated.modulate.lerp(Color(4.937, 0.876, 0.454, 1.0), .01)
