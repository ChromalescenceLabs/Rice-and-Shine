extends Control

@export var tween_intensity: float
@export var tween_duration : float

@onready var start: Button = $START
@onready var options: Button = $OPTIONS
@onready var quit: Button = $QUIT

func _process(_delta: float) -> void:
	btn_hovered(start)
	btn_hovered(options)
	btn_hovered(quit)

func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property,final_val, duration)

func btn_hovered(button: Button):
	button.pivot_offset = button.size / 2
	if button.is_hovered():
		start_tween(button, "scale", Vector2.ONE * tween_intensity, tween_duration)
	else:
		start_tween(button, "scale", Vector2.ONE, tween_duration)
