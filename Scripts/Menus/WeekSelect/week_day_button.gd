extends Button
const LOADING_SCREEN_FADE = preload("uid://dnkgil0k2g8ap")
var scene : String

func _on_pressed() -> void: SceneLoader.load_scene(scene, 2, LOADING_SCREEN_FADE)
