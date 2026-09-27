extends Control

@export var tween_intensity: float
@export var tween_duration : float

@onready var ch1: Button = $CH1BTN
@onready var ch2: Button = $CH2BTN
@onready var ch3: Button = $CH3BTN


func _process(_delta: float) -> void:
	btn_hovered(ch1)
	btn_hovered(ch2)
	btn_hovered(ch3)


func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property,final_val, duration)

func btn_hovered(button: Button):
	button.pivot_offset = button.size / 2
	if button.is_hovered():
		start_tween(button, "scale", Vector2.ONE * tween_intensity, tween_duration)
	else:
		start_tween(button, "scale", Vector2.ONE, tween_duration)
