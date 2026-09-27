extends Area2D
class_name Stick

var placed : Array:
	set(value):
		if not placed == value:
			placed = value
			
			if placed.size() >= 8:
				GlobalVars.successind(get_tree().current_scene)
				await GlobalVars.successIndEnd
