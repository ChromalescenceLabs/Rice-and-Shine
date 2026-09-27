extends Area2D
class_name StickComps

@onready var mallows: Sprite2D = $Mallows
@onready var chopped_hdog: Sprite2D = $ChoppedHdog

var type: String

func _input(event: InputEvent) -> void:
	if event.is_action_released("Click"):
		self.queue_free()

func _ready() -> void:
	match type:
		"Mallow": mallows.visible = true
		"Hotdog": chopped_hdog.visible = true

func _process(_delta: float) -> void:
	self.global_position = lerp(self.global_position, get_global_mouse_position(), 0.5)
