extends Control
@onready var container: CircularGridContainer = $"../New Selection/Container"
var last_select : String

func _ready() -> void:
	for child in container.get_children():
		child.mouse_entered.connect(changeBG.bind(true, child))
		child.mouse_exited.connect(changeBG.bind(false, child))

func changeBG(on, button):
	if on:
		for child in get_children():
			if child.name==button.name.to_lower():
				if not child.name == last_select:
					child.select()
					last_select = button.name.to_lower()
