extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_minigame_1_pressed() -> void:
	SceneLoader.load_scene("uid://sukerfnpt5d5", 1.5)


func _on_minigame_2_pressed() -> void:
	SceneLoader.load_scene("uid://bf86igy00f6sq", 1.5)


func _on_minigame_3_pressed() -> void:
	pass # Replace with function body.


func _on_minigame_4_pressed() -> void:
	pass # Replace with function body.


func _on_minigame_5_pressed() -> void:
	pass # Replace with function body.


func _on_minigame_6_pressed() -> void:
	pass # Replace with function body.
