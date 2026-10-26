extends Node2D
const CUSTOMER_SERVING_SANDBOX = preload("uid://cvg4i1rwk4hbd")


func _on_serve_customers_pressed() -> void:
	SceneLoader.load_scene("uid://cvg4i1rwk4hbd", 1.5)
