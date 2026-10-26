extends Button

func _on_pressed() -> void:
	SceneLoader.load_scene("uid://dniwio1arxhol", 1.5, SceneLoader.loading_screen_fade)
