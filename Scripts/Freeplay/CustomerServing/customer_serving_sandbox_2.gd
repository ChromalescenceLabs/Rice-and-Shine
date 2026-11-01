extends Node2D

func _ready() -> void:
	GlobalScenes.set_spawn_customers(3, 5)

func _on_exit_pressed() -> void:
	SceneLoader.load_scene("uid://b5ufcgv0qaktk", 1.5)
