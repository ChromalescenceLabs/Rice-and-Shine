extends Node2D
const CUSTOMER_SERVING_SANDBOX = preload("uid://bcxfv0rc6d7b")


func _on_serve_customers_pressed() -> void: SceneLoader.load_scene("uid://cfbo8eegeu5f0", 1.5)
