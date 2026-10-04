extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture = load("res://Assets/TEMPCLOSEDWINDOW.png")

func _on_freeplay_pressed() -> void:
	texture = load("res://Assets/TEMPOPENWINDOW.png")

func _on_freeplay_mouse_entered() -> void:
	texture = load("res://Assets/TEMPOPENWINDOW.png")

func _on_freeplay_mouse_exited() -> void:
	texture = load("res://Assets/TEMPCLOSEDWINDOW.png")
