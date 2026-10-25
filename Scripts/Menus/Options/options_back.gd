extends Button
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

func _on_pressed() -> void:
	animation_player.play_backwards("enterexit")
	await animation_player.animation_finished
	
	get_parent().queue_free()
