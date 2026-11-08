extends Button
const LOADING_SCREEN_FADE = preload("uid://dnkgil0k2g8ap")
var scene : String

func _on_pressed() -> void: SceneLoader.load_scene("uid://dsklae1f304tw", .5, LOADING_SCREEN_FADE)
