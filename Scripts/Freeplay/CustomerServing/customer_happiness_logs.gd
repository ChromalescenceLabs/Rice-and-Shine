extends Node2D
@onready var progress_bars_conts_anim: AnimationPlayer = $ProgressBarsContsAnim


func _on_show_progress_bars_pressed() -> void: progress_bars_conts_anim.play("Entrance_Exit")
func _on_close_progress_bars_pressed() -> void: progress_bars_conts_anim.play_backwards("Entrance_Exit")
