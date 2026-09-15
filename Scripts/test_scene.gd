extends Node2D

func _ready() -> void:
	await get_tree().create_timer(2.0).timeout
	
	SceneLoader.load_scene("uid://sukerfnpt5d5", 1.5)
