extends Node

# Credits to Michael Games for the tutorial on persistent data! 
# Modified for Rice and Shine :]

var current_save : Dictionary = {
	scenes_persistence = {}
}

func add_persistent_value(scene_name : String, data : Array) -> void:
	if check_persistent_value(scene_name) == false:
		current_save.scenes_persistence[scene_name] = data

func check_persistent_value(scene_name : String) -> bool:
	var p = current_save.scenes_persistence as Dictionary
	return p.has(scene_name)
	
func fetch_persistent_value(scene_name : String):
	if check_persistent_value(scene_name) == true:
		return current_save.scenes_persistence[scene_name]
	return null

func get_scene_path() -> String:
	return get_tree().current_scene.scene_file_path
