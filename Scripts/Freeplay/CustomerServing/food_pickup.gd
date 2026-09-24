extends Area2D
@onready var food_img: Sprite2D = $FoodImg

var texture : String

func _ready() -> void:
	food_img.visible = true

func _process(_delta: float) -> void:
		food_img.visible = true
		self.global_position = lerp(self.global_position, get_global_mouse_position(), 0.2)

func _input(event: InputEvent) -> void:
	if event.is_action_released("Click"):
		self.queue_free()
