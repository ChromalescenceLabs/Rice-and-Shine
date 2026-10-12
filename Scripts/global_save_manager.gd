extends Node

# Credits to Michael Games for the tutorial on persistent data! 
# Modified for Rice and Shine :]

# Structure:
# Current Save - Dictionary
# Scenes Persistence - Dictionary, holds Scene Name, Data
# Data - Dictionary, holds node name, data
# data - Array, holds the inner data
# This is written by Jazz, because I'm bad at keeping things in my head

var current_save : Dictionary = {
	scenes_persistence = {
		#Scene Name: {
		# Node Name: Data[],
		# Node2 Name : Data[]
		#}
	}
}

func add_persistent_value(scene_name : String, node_name : String, data : Array) -> void:
	if check_scene_persistent_value(scene_name):
		current_save.scenes_persistence[scene_name][node_name] = data
	else:
		current_save.scenes_persistence[scene_name] = {}
		current_save.scenes_persistence[scene_name][node_name] = data
		
func check_scene_persistent_value(scene_name : String) -> bool:
	var p = current_save.scenes_persistence as Dictionary
	return p.has(scene_name)
	
func fetch_scene_persistent_value(scene_name : String):
	if check_scene_persistent_value(scene_name) == true:
		return current_save.scenes_persistence[scene_name]
	return null

func fetch_node_persistent_value(dict: Dictionary, node_name : String):
	if dict.has(node_name):
		if dict[node_name].is_empty():
			return null
		else:
			return dict[node_name]
	return null

func get_scene_path() -> String:
	return get_tree().current_scene.scene_file_path
