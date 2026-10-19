extends Control

func _on_serve_customers_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Freeplay/customer_serving_sandbox.tscn")
	#SceneLoader.load_scene("uid://cvg4i1rwk4hbd", 1.5)
	#bro idk why this isn't working
