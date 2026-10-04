extends Area2D
class_name FoodPickup

@onready var food_img: Sprite2D = $FoodImg

var texture : String

var textureDict : Dictionary = {
	"rice" : load("uid://b8pycewahokgt"),
	"pancake" : load("uid://b8pycewahokgt"),
	"hashbrown" : load("uid://b8pycewahokgt")
}

func _ready() -> void:
	food_img.visible = true
	food_img.texture = textureDict.get(texture)

func _process(_delta: float) -> void:
		food_img.visible = true
		self.global_position = lerp(self.global_position, get_global_mouse_position(), 0.4)

func _input(event: InputEvent) -> void:
	if event.is_action_released("Click"):
		self.queue_free()
