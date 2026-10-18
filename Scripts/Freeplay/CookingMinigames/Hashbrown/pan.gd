extends Area2D

@onready var progress_bar_change_time: Timer = $"../ProgressBar/ProgressBarChangeTime"
@onready var progress_bar: ProgressBar = $"../ProgressBar"
@onready var grated: TextureRect = $Grated
@onready var potato: Area2D = $"../potato"
@onready var bowl: Area2D = $"../Bowl"

var has_hdog: bool = false
var has_oil: bool = false
var fried = false

func oiled() -> void:
	has_oil = true
	find_child("Pan").visible=false
	find_child("PanOil").visible=true

func unoil() -> void:
	has_oil = false
	find_child("Pan").visible=true
	find_child("PanOil").visible=false

func _on_grated_visibility_changed() -> void:
	progress_bar.visible=true
	progress_bar_change_time.start()
	if not potato.frying:
		bowl.find_child("BowlTop").visible=true

func _on_progress_bar_change_time_timeout() -> void:
	if progress_bar.value<100:
		progress_bar.value+=1
		grated.modulate = grated.modulate.lerp(Color(4.937, 0.914, 0.503, 1.0), .03)
	elif progress_bar.value==100:
		progress_bar_change_time.stop() 
		GlobalVars.shake(progress_bar)
		create_tween().tween_property(progress_bar, "modulate:a", 0, .5).set_trans(Tween.TRANS_CUBIC)
		await get_tree().create_timer(.2).timeout
		progress_bar.visible=false
		fried=true
		unoil()
