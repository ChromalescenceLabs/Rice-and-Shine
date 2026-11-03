extends Node2D
@onready var serving_customers_base: Node2D = $ServingCustomersBase

func _ready() -> void:
	GlobalScenes.set_spawn_customers(10, 20)

func _on_exit_pressed() -> void: SceneLoader.load_scene("uid://b5ufcgv0qaktk", 1.5)
