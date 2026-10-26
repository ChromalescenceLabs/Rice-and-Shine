extends Control
@onready var container: CircularGridContainer = $"../New Selection/Container"

func _ready() -> void:
	for child in container.get_children():
		child.mouse_entered.connect(changeBG.bind(true, child))
		child.mouse_exited.connect(changeBG.bind(false, child))

func changeBG(on, button):
	if on:
		for child in get_children():
			if child.name==button.name.to_lower():
				child.move_to_front()
				child.position.x += get_viewport().get_visible_rect().size.x
				create_tween().tween_property(child, "position", Vector2(0,0), .5).set_trans(Tween.TRANS_CUBIC)
