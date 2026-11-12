extends Button
@export var loading_scene : PackedScene = preload("uid://chgdopktb0d2w")

func _on_pressed() -> void: 
	SceneLoader.load_scene(GlobalVars.previous_scene, 1.5, loading_scene)
