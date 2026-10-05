extends AnimationPlayer

func _ready() -> void:
	pass
	
func _on_story_pressed() -> void:
	play("STORY")

func _on_freeplay_pressed() -> void:
	play("FREEPLAY")
