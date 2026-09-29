extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("Enter")

func _on_close_button_pressed() -> void:
	animation_player.play_backwards("Enter")
	await animation_player.animation_finished
	queue_free()
