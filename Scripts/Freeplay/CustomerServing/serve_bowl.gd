extends Area2D

var food_entered : bool = false

var contentDict : Dictionary = {}

func _on_area_entered(area: Area2D) -> void:
	if area is FoodPickup:
		var food = area.texture
		food_entered = true
		
		await area.tree_exited
		if food_entered == true:
			check_type(food)
			
			if not contentDict.has(food):
				contentDict[food] = 1
			else:
				contentDict[food] += 1

func _on_area_exited(area: Area2D) -> void:
	if area is FoodPickup and not area.is_queued_for_deletion():
		food_entered = false

func check_type(food):
	match food:
		"rice":
			GlobalVars.rice_value -= 1
		"pancake":
			GlobalVars.pcake_value -= 1
		"hashbrown":
			GlobalVars.hbrown_value -= 1
