extends Node2D
@onready var rice_cup_filled: Sprite2D = $RiceCupFilled

func _ready() -> void:
	rice_cup_filled.visible = true

func _process(_delta: float) -> void:
		rice_cup_filled.visible = true
		self.global_position = lerp(self.global_position, get_global_mouse_position(), 0.2)
	
func _input(event: InputEvent) -> void:
	if event.is_action_released("Click"):
		self.queue_free()
