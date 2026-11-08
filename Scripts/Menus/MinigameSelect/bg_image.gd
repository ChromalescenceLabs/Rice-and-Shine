extends Control
@onready var container: CircularGridContainer = $"../New Selection/Container"
@onready var customer_serving_button: Control = $"../New Selection/CustomerServingButton"
@onready var bg: TextureRect = $bg
var last_select : String

func _ready() -> void:
	for child in container.get_children():
		child.mouse_entered.connect(changeBG.bind(true, child))
		child.mouse_exited.connect(changeBG.bind(false, child))
		
	customer_serving_button.mouse_entered.connect(changeBG.bind(true, "BG"))
	customer_serving_button.mouse_exited.connect(changeBG.bind(false, "BG"))

func changeBG(on, button):
	if on:
		if not button is String:
			for child in get_children():
				if child.name==button.name.to_lower():
					if not child.name == last_select:
						child.select()
						last_select = button.name.to_lower()
		else:
			for child in get_children():
				if str(child.name) == button.to_lower():
					if not str(child.name) == last_select:
						bg.select()
						#child.select()
						last_select = button.to_lower()
