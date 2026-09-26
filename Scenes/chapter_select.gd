extends Control

#button anim variables
@export var tween_intensity: float
@export var tween_duration : float

@onready var label: Label = $Label
@onready var CH1text: Panel = $CH1TEXT
@onready var CH2text: Panel = $CH2TEXT
@onready var CH3text: Panel = $CH3TEXT
@onready var ch_1btn: Button = $CH1BTN
@onready var ch_2btn: Button = $CH2BTN
@onready var ch_3btn: Button = $CH3BTN

#makes it so that panel doesnt show immediately 
func _ready() -> void:
	CH1text.visible = false
	CH2text.visible = false
	CH3text.visible = false

func _process(_delta: float) -> void:
	btn_hovered(ch_1btn)
	btn_hovered(ch_2btn)
	btn_hovered(ch_3btn)

#button anim
func start_tween(object: Object, property: String, final_val: Variant, duration: float):
	var tween = create_tween()
	tween.tween_property(object, property,final_val, duration)

func btn_hovered(button: Button):
	button.pivot_offset = button.size / 2
	if button.is_hovered():
		start_tween(button, "scale", Vector2.ONE * tween_intensity, tween_duration)
	else:
		start_tween(button, "scale", Vector2.ONE, tween_duration)

#script so that panel "TEXT" pops up
func _on_ch_1btn_mouse_entered() -> void:
	CH1text.visible = true 
	label.text = "CHAPTER ONE"

func _on_ch_1btn_mouse_exited() -> void:
	CH1text.visible = false # Replace with function body.
	label.text = "CHAPTER SELECT"


func _on_ch_2btn_mouse_entered() -> void:
	CH2text.visible = true # Replace with function body.
	label.text = "CHAPTER TWO"

	
func _on_ch_2btn_mouse_exited() -> void:
	CH2text.visible = false
	label.text = "CHAPTER SELECT"


func _on_ch_3btn_mouse_entered() -> void:
	CH3text.visible = true
	label.text = "CHAPTER THREE"


func _on_ch_3btn_mouse_exited() -> void:
	CH3text.visible = false
	label.text = "CHAPTER SELECT"
