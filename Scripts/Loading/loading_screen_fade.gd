extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var duration = 0

signal loading_screen_ready

func _ready() -> void:
	animation_player.play("fade")
	await animation_player.animation_finished
	get_tree().paused = true
	loading_screen_ready.emit()
	
func _on_progress_changed(_new_value: float) -> void:
	pass
		
func _on_load_finished() -> void:
	Sfx.fade_master_volume(GlobalVars.current_db, duration)
	await get_tree().create_timer(duration).timeout
	animation_player.play_backwards("fade")
	await animation_player.animation_finished
	GlobalScenes.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = false
	queue_free()
