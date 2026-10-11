extends Node

var data : Dictionary

func _generated_entry_name(node_path_identifier : String) -> String:
	return str(get_tree().current_scene.get_path(), "/", node_path_identifier)
