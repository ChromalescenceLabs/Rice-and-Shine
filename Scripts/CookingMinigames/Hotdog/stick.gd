extends Area2D
class_name Stick
@export var mallows_bag: TextureRect
@export var hotdog_bowl: TextureRect

var placed : Array:
	set(value):
		if not placed == value:
			placed = value
			
			if placed.size() >= 5:
				GlobalVars.successind(get_tree().current_scene)
				mallows_bag.mouse_filter = Control.MOUSE_FILTER_IGNORE
				hotdog_bowl.mouse_filter = Control.MOUSE_FILTER_IGNORE
				await GlobalVars.successIndEnd
				get_tree().current_scene.sticks += 1
