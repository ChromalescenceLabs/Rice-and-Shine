extends AnimationPlayer
@onready var story: TextureButton = $"../STORY"
@onready var freeplay: TextureButton = $"../FREEPLAY"

func _ready() -> void:
	pass
	
func _on_story_pressed() -> void:
	play("STORY")
	story.disabled = true
	story.mouse_filter = Control.MOUSE_FILTER_IGNORE
	freeplay.disabled = true
	freeplay.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _on_freeplay_pressed() -> void:
	play("FREEPLAY")
	story.disabled = true
	story.mouse_filter = Control.MOUSE_FILTER_IGNORE
	freeplay.disabled = true
	freeplay.mouse_filter = Control.MOUSE_FILTER_IGNORE
