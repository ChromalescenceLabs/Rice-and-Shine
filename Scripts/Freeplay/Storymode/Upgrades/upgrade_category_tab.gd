@tool
extends ColorRect
@onready var rich_text_label: RichTextLabel = $HBoxContainer/RichTextLabel

@export var category_text : String = "":
	set(value):
		category_text = value
		_set_properties()

@export var bgcolor : Color:
	set(value):
		bgcolor = value
		_set_properties()

func _set_properties() -> void:
	if is_instance_valid(rich_text_label): rich_text_label.text = category_text
	self.color = bgcolor
	
